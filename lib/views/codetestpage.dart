import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../myappstate.dart';
import '../testframework/testrunner.dart';
import '../tests/plotting/logic/plotsequencerangescalertests.dart';
import '../tests/plotting/logic/plotsequencesrangefindertests.dart';
import '../tests/plotting/logic/plotsequencesrangescalertests.dart';
import '../tests/plotting/logic/plotsequencesunitsizescalertests.dart';
import '../tests/plotting/logic/plotviewporttests.dart';
import '../tests/utilities/converters/commandsequencetransferformattocommandsequenceconvertertests.dart';
import '../tests/utilities/converters/ircommandsequencetoplotsequenceconvertertests.dart';
import '../tests/utilities/tracehorizontalscalertests.dart';
import '../tests/utilities/tracesdatatests.dart';
import '../tests/utilities/tracepointstographdataseriesconvertertests.dart';
import '../tests/utilities/traceverticalscalertests.dart';

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
    runner.addTests(TraceHorizontalScalerTests());
    runner.addTests(TraceVerticalScalerTests());
    runner.addTests(TracesDataTests());
    runner.addTests(CommandsListFromApiCommandsConverterTests());
    runner.addTests(IrCommandSequenceToPlotSequenceConverterTests());
    runner.addTests(PlotSequencesUnitSizeScalerTests());
    runner.addTests(PlotSequencesRangeFinderTests());
    runner.addTests(PlotSequencesRangeScalerTests());
    runner.addTests(PlotSequenceRangeScalerTests());
    runner.addTests(PlotViewportTests());

    var results = runner.runTests();

    var widgets = results.map((r) => Text(r));

    return widgets.toList();
  }
}
