import 'package:flutter/material.dart';
import 'testing/testrunner.dart';
import 'tests/utilities/tracevaluerangefindertests.dart';

class CodeTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: makeTraceViewPage());
  }

  List<Widget> makeTraceViewPage() {
    var runner = TestRunner();

    runner.addTests(TraceValueRangeFinderTests());

    var results = runner.runTests();

    var widgets = results.map((r) => Text(r));

    return widgets.toList();

    // List<TestUnit> tests = List.empty(growable: true);

    // tests.addAll(TracePlotterTests.getTests());
    // tests.addAll(TraceValueRangeFinderTests.getTests());

    // var testWidgets = tests.map((test) => createWidgetFromTest(test));

    // return testWidgets.toList();

    // return <Widget>[
    //   Text('ssdfdsfdsf33'),
    // ];
  }

  // Widget createWidgetFromTest(TestUnit test) {
  //   var name = test.name;
  //   var result = test.action();

  //   var text = 'Test $name $result';

  //   return Text(text);
  // }
}
