import '../../../plotting/dataobjects/plotsequencesrange.dart';
import '../../../plotting/logic/iplotsequencerangescaler.dart';
import '../../../plotting/logic/plotsequencesrangescaler.dart';
import '../../../potentiallibrary/graphs/seriesdata/graphdatapoint.dart';
import '../../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import '../../../testframework/testmodule.dart';
import '../../../testframework/testunit.dart';

class PlotSequencesRangeScalerTests extends TestModule {
  late PlotSequencesRangeScaler _scaler;
  late MockPlotSequenceRangeScaler _mockPlotSequenceRangeScaler;
  late PlotSequencesRange _plotSequencesRange;
  late GraphDataSeries _unscaledPlotSequence1;
  late GraphDataSeries _unscaledPlotSequence2;
  late GraphDataSeries _unscaledPlotSequence3;
  late GraphDataSeries _scaledPlotSequence1;
  late GraphDataSeries _scaledPlotSequence2;
  late GraphDataSeries _scaledPlotSequence3;

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
    _unscaledPlotSequence1 = GraphDataSeries([GraphDataPoint(1, 2)]);
    _unscaledPlotSequence2 = GraphDataSeries([GraphDataPoint(2, 2)]);
    _unscaledPlotSequence3 = GraphDataSeries([GraphDataPoint(3, 2)]);
    _scaledPlotSequence1 = GraphDataSeries([GraphDataPoint(4, 2)]);
    _scaledPlotSequence2 = GraphDataSeries([GraphDataPoint(5, 2)]);
    _scaledPlotSequence3 = GraphDataSeries([GraphDataPoint(6, 2)]);
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
  List<GraphDataSeries> from;
  List<GraphDataSeries> to;
  PlotSequencesRange range;
  MockPlotSequenceRangeScaler(this.from, this.to, this.range);

  @override
  GraphDataSeries scalePlotSequence(
      GraphDataSeries plotSequence, PlotSequencesRange range) {
    for (var i = 0; i < from.length; i++) {
      if (from[i] == plotSequence) {
        return to[i];
      }
    }
    throw UnimplementedError();
  }
}

//#endregion
