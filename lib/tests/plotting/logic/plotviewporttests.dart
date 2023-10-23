import 'package:ircommandmanager/plotting/logic/plotviewport.dart';
import 'package:ircommandmanager/testframework/testmodule.dart';
import 'package:ircommandmanager/testframework/testunit.dart';

import '../../../potentiallibrary/graphs/seriesdata/graphdatapoint.dart';

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
      GraphDataPoint(0, 0),
      GraphDataPoint(1, 0),
      GraphDataPoint(1, 1),
      GraphDataPoint(0, 1),
      GraphDataPoint(0.5, 0.5),
    ];

    var results = _viewport.scaleToViewport(plotSequences, 100, 200);

    assertEqual(results, [
      GraphDataPoint(0, 0),
      GraphDataPoint(100, 0),
      GraphDataPoint(100, 200),
      GraphDataPoint(0, 200),
      GraphDataPoint(50, 100),
    ]);
  }

  //#region Supporting Code

  @override
  void setUpObjectUnderTest() {
    _viewport = PlotViewport();
  }
}

//#endregion
