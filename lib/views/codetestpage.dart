import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../myappstate.dart';
import '../potentiallibrary/testframework/testrunner.dart';
import '../tests/plotting/logic/plotsequencerangescalertests.dart';
import '../tests/potentiallibrary/graphs/scaling/graphseriesextentcalculatortests.dart';
import '../tests/plotting/logic/plotsequencesrangescalertests.dart';
import '../tests/plotting/logic/plotsequencesunitsizescalertests.dart';
import '../tests/plotting/logic/plotviewporttests.dart';
import '../tests/potentiallibrary/widgets/myselectablelisttests.dart';
import '../tests/tracetoircodeconversion/tracetoircodeconvertertests.dart';
import '../tests/utilities/converters/commandsequencetransferformattocommandsequenceconvertertests.dart';
import '../tests/utilities/tracepointstographdataseriesconvertertests.dart';

class CodeTestPage extends StatefulWidget {
  @override
  State<CodeTestPage> createState() => _CodeTestPageState();
}

class _CodeTestPageState extends State<CodeTestPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return ListView(children: makeTraceViewPage(appState));
  }

  List<Widget> makeTraceViewPage(MyAppState appState) {
    return <Widget>[
      OverflowBar(
        alignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Show Test Plots'),
          Checkbox(
              value: appState.showTestPlots,
              onChanged: (bool? x) => setState(() {
                    appState.showTestPlots = !appState.showTestPlots;
                  })),
        ],
      ),
      for (var w in runTestsAndReturnResults()) w
    ];
  }

  List<Widget> runTestsAndReturnResults() {
    var runner = TestRunner();

    runner.addTests(TracePointsToGraphDataSeriesConverterTests());
    runner.addTests(CommandsListFromApiCommandsConverterTests());
    runner.addTests(PlotSequencesUnitSizeScalerTests());
    runner.addTests(GraphSeriesExtentCalculatorTests());
    runner.addTests(PlotSequencesRangeScalerTests());
    runner.addTests(PlotSequenceRangeScalerTests());
    runner.addTests(PlotViewportTests());
    runner.addTests(MySelectableListTests());
    runner.addTests(TraceToIrCodeConverterTests());

    var results = runner.runTests();

    var widgets = results.map((r) => Text(r));

    return widgets.toList();
  }
}
