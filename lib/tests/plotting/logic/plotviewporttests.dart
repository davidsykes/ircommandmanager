import 'package:ircommandmanager/plotting/dataobjects/plotvalue.dart';
import 'package:ircommandmanager/plotting/logic/plotviewport.dart';
import 'package:ircommandmanager/testing/testmodule.dart';
import 'package:ircommandmanager/testing/testunit.dart';

class PlotViewportTests extends TestModule {
  late PlotViewport _viewport;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aSimpleSequenceIsScaledToFitTheViewport),
    ];
  }

  void aSimpleSequenceIsScaledToFitTheViewport() {
    var plotSequences = [
      PlotValue(0, 0),
      PlotValue(1, 0),
      PlotValue(1, 1),
      PlotValue(0, 1),
      PlotValue(0.5, 0.5),
    ];

    var results = _viewport.scaleToViewport(plotSequences, 100, 200);

    assertEqual(results, [
      PlotValue(0, 0),
      PlotValue(100, 0),
      PlotValue(100, 200),
      PlotValue(0, 200),
      PlotValue(50, 100),
    ]);
  }

  //#region Supporting Code

  @override
  void setUpObjectUnderTest() {
    _viewport = PlotViewport();
  }
}

//#endregion
