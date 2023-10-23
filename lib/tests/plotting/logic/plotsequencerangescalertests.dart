import 'package:ircommandmanager/potentiallibrary/graphs/scaling/graphseriesextent.dart';
import 'package:ircommandmanager/potentiallibrary/graphs/seriesdata/graphdatapoint.dart';
import '../../../plotting/logic/plotsequencerangescaler.dart';
import '../../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import '../../../testframework/testmodule.dart';
import '../../../testframework/testunit.dart';

class PlotSequenceRangeScalerTests extends TestModule {
  late PlotSequenceRangeScaler _scaler;
  late GraphDataSeries _plotSequence;
  late GraphSeriesExtent _plotSequencesRange;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aSequenceisScaled),
    ];
  }

  void aSequenceisScaled() {
    var scaled = _scaler.scalePlotSequence(_plotSequence, _plotSequencesRange);

    assertEqual(scaled.plots[0], GraphDataPoint(0, 0));
    assertEqual(scaled.plots[1], GraphDataPoint(1, 0));
    assertEqual(scaled.plots[2], GraphDataPoint(0, 1));
    assertEqual(scaled.plots[3], GraphDataPoint(1, 1));
    assertEqual(scaled.plots[4], GraphDataPoint(0.5, 0.5));
  }

  //#region Supporting Code

  @override
  void setUpData() {
    _plotSequencesRange = GraphSeriesExtent(10, 20, 300, 400);
    _plotSequence = GraphDataSeries([
      GraphDataPoint(10, 300),
      GraphDataPoint(20, 300),
      GraphDataPoint(10, 400),
      GraphDataPoint(20, 400),
      GraphDataPoint(15, 350),
    ]);
  }

  @override
  void setUpObjectUnderTest() {
    _scaler = PlotSequenceRangeScaler();
  }
}

//#endregion
