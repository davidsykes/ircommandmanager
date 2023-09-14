import 'package:ircommandmanager/plotting/dataobjects/plotsequence.dart';
import 'package:ircommandmanager/plotting/dataobjects/plotsequencesrange.dart';
import 'package:ircommandmanager/plotting/dataobjects/plotvalue.dart';

import '../../../plotting/logic/plotsequencerangescaler.dart';
import '../../../testing/testmodule.dart';
import '../../../testing/testunit.dart';

class PlotSequenceRangeScalerTests extends TestModule {
  late PlotSequenceRangeScaler _scaler;
  late PlotSequence _plotSequence;
  late PlotSequencesRange _plotSequencesRange;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aSequenceisScaled),
    ];
  }

  void aSequenceisScaled() {
    var scaled = _scaler.scalePlotSequence(_plotSequence, _plotSequencesRange);

    assertEqual(scaled.plots[0], PlotValue(0, 0));
    assertEqual(scaled.plots[1], PlotValue(1, 0));
    assertEqual(scaled.plots[2], PlotValue(0, 1));
    assertEqual(scaled.plots[3], PlotValue(1, 1));
    assertEqual(scaled.plots[4], PlotValue(0.5, 0.5));
  }

  //#region Supporting Code

  @override
  void setUpData() {
    _plotSequencesRange = PlotSequencesRange(10, 20, 300, 400);
    _plotSequence = PlotSequence([
      PlotValue(10, 300),
      PlotValue(20, 300),
      PlotValue(10, 400),
      PlotValue(20, 400),
      PlotValue(15, 350),
    ]);
  }

  @override
  void setUpObjectUnderTest() {
    _scaler = PlotSequenceRangeScaler();
  }
}

//#endregion
