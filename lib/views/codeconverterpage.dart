import 'package:flutter/material.dart';
import 'package:ircommandmanager/codeconversion/codetobeconverted.dart';
import 'package:ircommandmanager/dataobjects/traces/tracepoint.dart';

class CodeConverterPage extends StatefulWidget {
  final CodeToBeConverted codeToBeConverted;
  const CodeConverterPage(this.codeToBeConverted, {super.key});

  @override
  State<CodeConverterPage> createState() => _CodeConverterPageState();
}

class _CodeConverterPageState extends State<CodeConverterPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.codeToBeConverted.getTracePoints().points.isEmpty) {
      return Text('Nothing to see here');
    }
    return Column(
      children: [
        Text('asfasdf'),
        Row(
          children: <Widget>[
            Expanded(
              flex: 50,
              child: makeUncovertedPage(),
            ),
            Expanded(
              flex: 50,
              child: makeCovertedPage(),
            ),
          ],
        ),
      ],
    );
  }

  Widget makeUncovertedPage() {
    var points = widget.codeToBeConverted.getTracePoints().points;
    var texts = points.map((e) => tracePointToText(e));
    var widgets = texts.map((e) => Text(e));
    return Column(
      children: widgets.toList(),
    );
  }

  tracePointToText(TracePoint point) {
    var t = point.time;
    var v = point.value;
    return '$t: $v';
  }

  Widget makeCovertedPage() {
    var points = convert(widget.codeToBeConverted.getTracePoints().points);
    var texts = points.map((e) => tracePointToText(e));
    var widgets = texts.map((e) => Text(e));
    return Column(
      children: widgets.toList(),
    );
  }

  List<TracePoint> convert(List<TracePoint> points) {
    return points
        .map((e) => TracePoint(time: e.time, value: e.value >= 128 ? 0 : 1))
        .toList()
        .sublist(1);
  }
}
