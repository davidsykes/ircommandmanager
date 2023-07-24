import 'package:flutter/material.dart';
import '../testing/testrunner.dart';
import '../tests/utilities/scalinghelpertests.dart';
import '../tests/utilities/tracetolinesconvertertests.dart';
import '../tests/utilities/tracevaluerangefindertests.dart';

class CodeTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: makeTraceViewPage());
  }

  List<Widget> makeTraceViewPage() {
    var runner = TestRunner();

    runner.addTests(TraceValueRangeFinderTests());
    runner.addTests(TraceToLinesConverterTests());
    runner.addTests(ScalingHelperTests());

    var results = runner.runTests();

    var widgets = results.map((r) => Text(r));

    return widgets.toList();
  }
}
