import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dataobjects/traces/selectabletraceinfo.dart';
import '../dataobjects/traces/tracesdata.dart';
import '../myappstate.dart';
import '../webservices/scopetraces/scopetraceaccess.dart';

class ViewTraceListPage extends StatefulWidget {
  const ViewTraceListPage({super.key});

  @override
  State<ViewTraceListPage> createState() => _ViewTraceListPageFutureBuilder();
}

class _ViewTraceListPageFutureBuilder extends State<ViewTraceListPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var loadTracelistFuture = getTraces(appState);

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<TracesData>(
        future: loadTracelistFuture,
        builder: (BuildContext context, AsyncSnapshot<TracesData> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = makeTraceViewPage(snapshot.data!);
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }

  List<Widget> makeTraceViewPage(TracesData traces) {
    return <Widget>[
      OverflowBar(
        alignment: MainAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                setState(() {
                  refreshTraces();
                });
              },
              child: Text('Refresh')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  deleteTraces(traces);
                });
              },
              child: Text('Delete')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  selectAllTraces(traces);
                });
              },
              child: Text('Select All')),
        ],
      ),
      Expanded(
          child: ListView(
        children: <Widget>[
          for (var p in traces.getAllTraces()) makeTraceListItem(p)
        ],
      )),
    ];
  }

  Widget makeTraceListItem(SelectableTraceInfo selectableTrace) {
    var trace = selectableTrace.traceInfo;
    return ListTile(
      leading: Checkbox(
        value: selectableTrace.isSelected(),
        onChanged: (bool? x) => setState(() {
          selectableTrace.toggle();
        }),
      ),
      title: Text(trace.name),
      subtitle: Text('${trace.traceCount} traces. ${trace.traceLength}uS'),
    );
  }

  static Future<TracesData> getTraces(MyAppState appState) async {
    try {
      var traces = await ScopeTraceAccess()
          .getTraceDataController()
          .getTracesDataFuture();
      return traces;
    } catch (e) {
      return Future.error('Error getting traces: $e');
    }
  }

  void deleteTraces(TracesData traces) {
    var tracesToDelete = traces
        .getAllTraces()
        .where((trace) => trace.isSelected())
        .map((trace) => trace.traceInfo.fileName);

    ScopeTraceAccess().deleteTraces(tracesToDelete);
  }

  void selectAllTraces(TracesData traces) {
    for (var trace in traces.getAllTraces()) {
      if (!trace.isSelected()) {
        trace.toggle();
      }
    }
  }

  void refreshTraces() {
    ScopeTraceAccess().getTraceDataController().refreshTraces();
  }
}
