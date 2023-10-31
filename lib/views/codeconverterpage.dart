import 'package:flutter/material.dart';
import 'package:ircommandmanager/tracetoircodeconversion/codetobeconverted.dart';
import 'package:ircommandmanager/dataobjects/traces/tracepoint.dart';
import 'package:ircommandmanager/potentiallibrary/widgets/elevatedbutton.dart';

import '../tracetoircodeconversion/tracetoircodeconverter.dart';

class CodeConverterPage extends StatefulWidget {
  final CodeToBeConverted codeToBeConverted;
  const CodeConverterPage(this.codeToBeConverted, {super.key});

  @override
  State<CodeConverterPage> createState() => _CodeConverterPageState();
}

class _CodeConverterPageState extends State<CodeConverterPage> {
  final myController = TextEditingController();
  final _traceToIrCodeConverter = TraceToIrCodeConverter();

  @override
  Widget build(BuildContext context) {
    if (widget.codeToBeConverted.getTracePoints().points.isEmpty) {
      return Text('Nothing to see here');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        makeTopRow(),
        Row(
          children: <Widget>[
            Expanded(
              flex: 50,
              child: makeUnconvertedPage(),
            ),
            Expanded(
              flex: 50,
              child: makeConvertedPage(),
            ),
          ],
        ),
      ],
    );
  }

  Widget makeTopRow() {
    return Row(
      children: [
        Text('Code name'),
        SizedBox(
          width: 300,
          child: Flexible(
            child: TextField(
              controller: myController,
            ),
          ),
        ),
        createElevatedButton('Save', () {
          print(myController.text);
        }),
      ],
    );
  }

  Widget makeUnconvertedPage() {
    var points = widget.codeToBeConverted.getTracePoints().points;
    var texts = points.map((e) => tracePointToText(e));
    var widgets = texts.map((e) => Text(e));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets.toList(),
    );
  }

  String tracePointToText(TracePoint point) {
    var t = point.time;
    var v = point.value;
    return '$t: $v';
  }

  Widget makeConvertedPage() {
    var code = _traceToIrCodeConverter.convert(
        'name', widget.codeToBeConverted.getTracePoints().points);
    var texts = code.wavepoints.map((e) => wavePointToText(e));
    var widgets = texts.map((e) => Text(e));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets.toList(),
    );
  }

  String wavePointToText(List<int> p) {
    return '${p[0]}: ${p[1]}';
  }
}
