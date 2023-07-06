import 'package:flutter/material.dart';
import 'package:ircommandmanager/webaccess.dart';
import 'package:provider/provider.dart';
import 'dataobjects/selectabletraceinfo.dart';
import 'myappstate.dart';

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
      child: FutureBuilder<List<SelectableTraceInfo>>(
        future: loadTracelistFuture,
        builder: (BuildContext context,
            AsyncSnapshot<List<SelectableTraceInfo>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = makeTraceViewPage(appState, snapshot.data!);
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

  List<Widget> makeTraceViewPage(
      MyAppState appState, List<SelectableTraceInfo> traces) {
    return <Widget>[
      ButtonBar(
        alignment: MainAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                deleteTraces(traces);
              },
              child: Text('Delete')),
        ],
      ),
      const Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 60,
      ),
      Expanded(
          child: ListView(
        children: <Widget>[
          for (var p in traces) makeTraceListItem(appState, traces, p)
        ],
      )),
    ];
  }

  Widget makeTraceListItem(
      MyAppState appState,
      List<SelectableTraceInfo> selectableTraces,
      SelectableTraceInfo selectableTrace) {
    var trace = selectableTrace.traceInfo;
    return ListTile(
      leading: Checkbox(
        value: selectableTrace.selected,
        onChanged: (bool? x) => setState(() {
          selectableTrace.toggle();
        }),
      ),
      title: Text(trace.name),
      subtitle: Text('${trace.traceCount} traces. ${trace.traceLength}uS'),
    );
  }

  static Future<List<SelectableTraceInfo>> getTraces(
      MyAppState appState) async {
    var traces = await appState.getTraceList();
    return traces;
  }

  void deleteTraces(List<SelectableTraceInfo> traces) {
    var tracesToDelete = traces
        .where((trace) => trace.selected)
        .map((trace) => trace.traceInfo.fileName);

    WebAccess.deleteTraces(tracesToDelete);
  }
}
