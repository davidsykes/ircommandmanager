import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dataobjects/traceinfo.dart';
import 'myappstate.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var loadTracelistFuture = getSelectedTraces(appState);

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<List<TraceInfo>>(
        future: loadTracelistFuture,
        builder:
            (BuildContext context, AsyncSnapshot<List<TraceInfo>> snapshot) {
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

  List<Widget> makeTraceViewPage(MyAppState appState, List<TraceInfo> traces) {
    return <Widget>[
      Expanded(
          child: ListView(
        children: <Widget>[
          for (var p in traces) makeTraceListItem(appState, traces, p)
        ],
      )),
    ];
  }

  Widget makeTraceListItem(
      MyAppState appState, List<TraceInfo> selectableTraces, TraceInfo trace) {
    return ListTile(
      leading: Text(trace.name),
      title: Text(trace.name),
      subtitle: Text('${trace.traceCount} traces. ${trace.traceLength}uS'),
    );
  }

  static Future<List<TraceInfo>> getSelectedTraces(MyAppState appState) async {
    var traces = await appState.getSelectedTracesWithDetails();
    return traces;
  }
}
