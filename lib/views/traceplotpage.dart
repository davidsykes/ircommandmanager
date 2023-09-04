import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../plotting/view/plotviewcontrolvariables.dart';
import '../dataobjects/traces/traceinfo.dart';
import '../myappstate.dart';
import '../tracepainter.dart';

class TracePlotPage extends StatefulWidget {
  @override
  State<TracePlotPage> createState() => _TracePlotPageState();
}

class _TracePlotPageState extends State<TracePlotPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var loadTracelistFuture = getSelectedTracesWithDetails(appState);

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

  static Future<List<TraceInfo>> getSelectedTracesWithDetails(
      MyAppState appState) async {
    var traces =
        await appState.getTraceDataController().getSelectedTracesWithDetails();
    return traces;
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
      Text('Zoom'),
      Slider(
          value: plotViewControlVariables.zoom.toDouble() * 4,
          min: 4,
          max: 100,
          label: plotViewControlVariables.zoom.toString(),
          onChanged: (double value) {
            setState(() {
              plotViewControlVariables.zoom = (value / 4).round();
            });
          }),
      Text('Pan'),
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
}
