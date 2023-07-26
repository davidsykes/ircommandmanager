import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dataobjects/traceinfo.dart';
import '../myappstate.dart';
import '../tracepainter.dart';

class TracePlotPage extends StatelessWidget {
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
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color.fromARGB(255, 155, 22, 22)),
                left: BorderSide(color: Color(0xFFFFFFFF)),
                right: BorderSide(),
                bottom: BorderSide(),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }

  //https://stackoverflow.com/a/74161144/259

  List<Widget> makeTraceViewPage(MyAppState appState, List<TraceInfo> traces) {
    final redrawTrigger = ValueNotifier<int>(0); // 1. the important bit
    return <Widget>[
      ButtonBar(
        alignment: MainAxisAlignment.start,
        children: createButtonBar(appState),
      ),
      Expanded(
          child: CustomPaint(
        size: Size.infinite,
        painter:
            MyPainter(state: appState, traces: traces, notifier: redrawTrigger),
      )),
    ];
  }

  static Future<List<TraceInfo>> getSelectedTraces(MyAppState appState) async {
    var traces = await appState.getSelectedTracesWithDetails();
    return traces;
  }

  List<Widget> createButtonBar(MyAppState appState) {
    return <Widget>[
      ElevatedButton(
          onPressed: () {
            zoomIn(appState);
          },
          child: Text('+')),
      ElevatedButton(
          onPressed: () {
            zoomOut(appState);
          },
          child: Text('-')),
    ];
  }

  void zoomIn(MyAppState appState) {
    appState.scroll++;
  }

  void zoomOut(MyAppState appState) {
    appState.scroll--;
  }
}
