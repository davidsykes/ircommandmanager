import '../../../plotting/dataobjects/plotsequencesrange.dart';
import '../../../plotting/logic/iplotsequencesrangefinder.dart';
import '../../../plotting/logic/iplotsequencesrangescaler.dart';
import '../../../plotting/logic/plotsequencesunitsizescaler.dart';
import '../../../potentiallibrary/graphs/seriesdata/graphdatapoint.dart';
import '../../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import '../../../testframework/testmodule.dart';
import '../../../testframework/testunit.dart';

class PlotSequencesUnitSizeScalerTests extends TestModule {
  late PlotSequencesUnitSizeScaler _scaler;
  late MockPlotSequencesRangeFinder mockPlotSequencesRangeFinder;
  late MockPlotSequencesRangeScaler mockPlotSequencesRangeScaler;
  var plotSequencesCalculatedRange = PlotSequencesRange(1, 2, 3, 4);
  late List<GraphDataSeries> _scaledPlotSequences;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(plotSequencesArePassedToTheRangeFinder),
      createTest(plotSequencesArePassedToThePlotSequencesScaler),
      createTest(unitScaledPlotSequencesAreReturned),
    ];
  }

  void plotSequencesArePassedToTheRangeFinder() {
    var plotSequences = creatPlotSequences();

    _scaler.scaleToUnitSize(plotSequences);

    assertSameObject(mockPlotSequencesRangeFinder.sequences, plotSequences);
  }

  void plotSequencesArePassedToThePlotSequencesScaler() {
    var plotSequences = creatPlotSequences();

    _scaler.scaleToUnitSize(plotSequences);

    assertSameObject(mockPlotSequencesRangeScaler.sequences, plotSequences);
    assertSameObject(mockPlotSequencesRangeScaler.plotSequencesRange,
        plotSequencesCalculatedRange);
  }

  void unitScaledPlotSequencesAreReturned() {
    var plotSequences = creatPlotSequences();

    var scaled = _scaler.scaleToUnitSize(plotSequences);

    assertSameObject(scaled, _scaledPlotSequences);
  }

  //#region Supporting Code

  @override
  setUpData() {
    _scaledPlotSequences = [
      GraphDataSeries([GraphDataPoint(1, 2)])
    ];
  }

  @override
  setUpMocks() {
    mockPlotSequencesRangeFinder =
        MockPlotSequencesRangeFinder(plotSequencesCalculatedRange);
    mockPlotSequencesRangeScaler =
        MockPlotSequencesRangeScaler(_scaledPlotSequences);
  }

  @override
  void setUpObjectUnderTest() {
    _scaler = PlotSequencesUnitSizeScaler(
        mockPlotSequencesRangeFinder, mockPlotSequencesRangeScaler);
  }

  List<GraphDataSeries> creatPlotSequences() {
    return [
      GraphDataSeries([GraphDataPoint(100, 100)])
    ];
  }
}

class MockPlotSequencesRangeFinder extends IPlotSequencesRangeFinder {
  List<GraphDataSeries> sequences = List.empty();
  PlotSequencesRange range;

  MockPlotSequencesRangeFinder(this.range);

  @override
  PlotSequencesRange calculateRange(List<GraphDataSeries> plotSequences) {
    sequences = plotSequences;
    return range;
  }
}

class MockPlotSequencesRangeScaler extends IPlotSequencesRangeScaler {
  List<GraphDataSeries> sequences = List.empty();
  late PlotSequencesRange plotSequencesRange;
  late List<GraphDataSeries> _scaledPlotSequences;

  MockPlotSequencesRangeScaler(this._scaledPlotSequences);

  @override
  List<GraphDataSeries> scalePlotSequences(
      List<GraphDataSeries> plotSequences, PlotSequencesRange range) {
    sequences = plotSequences;
    plotSequencesRange = range;
    return _scaledPlotSequences;
  }
}

//#endregion
