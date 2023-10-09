import '../../../plotting/dataobjects/plotsequence.dart';
import '../../../plotting/dataobjects/plotsequencesrange.dart';
import '../../../plotting/dataobjects/plotvalue.dart';
import '../../../plotting/logic/iplotsequencerangescaler.dart';
import '../../../plotting/logic/plotsequencesrangescaler.dart';
import '../../../testframework/testmodule.dart';
import '../../../testframework/testunit.dart';

class PlotSequencesRangeScalerTests extends TestModule {
  late PlotSequencesRangeScaler _scaler;
  late MockPlotSequenceRangeScaler _mockPlotSequenceRangeScaler;
  late PlotSequencesRange _plotSequencesRange;
  late PlotSequence _unscaledPlotSequence1;
  late PlotSequence _unscaledPlotSequence2;
  late PlotSequence _unscaledPlotSequence3;
  late PlotSequence _scaledPlotSequence1;
  late PlotSequence _scaledPlotSequence2;
  late PlotSequence _scaledPlotSequence3;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(allSequencesArePassedToTheSingleItemScaler),
    ];
  }

  void allSequencesArePassedToTheSingleItemScaler() {
    var plotSequences = [
      _unscaledPlotSequence1,
      _unscaledPlotSequence2,
      _unscaledPlotSequence3
    ];

    var scaled = _scaler.scalePlotSequences(plotSequences, _plotSequencesRange);

    assertEqual(scaled,
        [_scaledPlotSequence1, _scaledPlotSequence2, _scaledPlotSequence3]);
  }

  //#region Supporting Code

  @override
  void setUpData() {
    _plotSequencesRange = PlotSequencesRange(1, 2, 3, 4);
    _unscaledPlotSequence1 = PlotSequence([PlotValue(1, 2)]);
    _unscaledPlotSequence2 = PlotSequence([PlotValue(2, 2)]);
    _unscaledPlotSequence3 = PlotSequence([PlotValue(3, 2)]);
    _scaledPlotSequence1 = PlotSequence([PlotValue(4, 2)]);
    _scaledPlotSequence2 = PlotSequence([PlotValue(5, 2)]);
    _scaledPlotSequence3 = PlotSequence([PlotValue(6, 2)]);
  }

  @override
  void setUpMocks() {
    _mockPlotSequenceRangeScaler = MockPlotSequenceRangeScaler([
      _unscaledPlotSequence1,
      _unscaledPlotSequence2,
      _unscaledPlotSequence3
    ], [
      _scaledPlotSequence1,
      _scaledPlotSequence2,
      _scaledPlotSequence3
    ], _plotSequencesRange);
  }

  @override
  void setUpObjectUnderTest() {
    _scaler = PlotSequencesRangeScaler(_mockPlotSequenceRangeScaler);
  }
}

class MockPlotSequenceRangeScaler extends IPlotSequenceRangeScaler {
  List<PlotSequence> from;
  List<PlotSequence> to;
  PlotSequencesRange range;
  MockPlotSequenceRangeScaler(this.from, this.to, this.range);

  @override
  PlotSequence scalePlotSequence(
      PlotSequence plotSequence, PlotSequencesRange range) {
    for (var i = 0; i < from.length; i++) {
      if (from[i] == plotSequence) {
        return to[i];
      }
    }
    throw UnimplementedError();
  }
}

//#endregion
