import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dataobjects/plotviewcontrolvariables.dart';
import '../dataobjects/traceinfo.dart';
import '../myappstate.dart';
import '../tracepainter.dart';

class TracePlotPage extends StatefulWidget {
  @override
  State<TracePlotPage> createState() => _TracePlotPageState();

  static Future<List<TraceInfo>> getSelectedTraces(MyAppState appState) async {
    var traces = await appState.getSelectedTracesWithDetails();
    return traces;
  }
}

class _TracePlotPageState extends State<TracePlotPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var loadTracelistFuture = TracePlotPage.getSelectedTraces(appState);

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<List<TraceInfo>>(
        future: loadTracelistFuture,
        builder:
            (BuildContext context, AsyncSnapshot<List<TraceInfo>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = makeTraceViewPage(
                appState.plotViewControlVariables, snapshot.data!);
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

  List<Widget> makeTraceViewPage(
      PlotViewControlVariables plotViewControlVariables,
      List<TraceInfo> traces) {
    return <Widget>[
      ButtonBar(
        alignment: MainAxisAlignment.start,
        children: createButtonBar(plotViewControlVariables),
      ),
      Expanded(
          child: CustomPaint(
        size: Size.infinite,
        painter: MyPainter(
            plotViewControlVariables: plotViewControlVariables, traces: traces),
      )),
    ];
  }

  List<Widget> createButtonBar(
      PlotViewControlVariables plotViewControlVariables) {
    return <Widget>[
      ElevatedButton(
          onPressed: () {
            zoomIn(plotViewControlVariables);
          },
          child: Text('+')),
      ElevatedButton(
          onPressed: () {
            zoomOut(plotViewControlVariables);
          },
          child: Text('-')),
      Slider(
          value: plotViewControlVariables.zoom.toDouble(),
          min: 1,
          max: 100,
          label: plotViewControlVariables.zoom.toString(),
          onChanged: (double value) {
            setState(() {
              plotViewControlVariables.zoom = value.round();
            });
          }),
      Slider(
          value: plotViewControlVariables.offset.toDouble(),
          min: 0,
          max: 99,
          label: plotViewControlVariables.offset.toString(),
          onChanged: (double value) {
            setState(() {
              plotViewControlVariables.offset = value.round();
            });
          }),
    ];
  }

  void zoomIn(PlotViewControlVariables plotViewControlVariables) {
    setState(() {
      plotViewControlVariables.zoom++;
    });
  }

  void zoomOut(PlotViewControlVariables plotViewControlVariables) {
    setState(() {
      plotViewControlVariables.zoom--;
    });
  }
}
