import '../../../potentiallibrary/graphs/scaling/graphseriesextent.dart';
import '../../../plotting/logic/iplotsequencesrangescaler.dart';
import '../../../plotting/logic/plotsequencesunitsizescaler.dart';
import '../../../potentiallibrary/graphs/scaling/graphseriesextentcalculator.dart';
import '../../../potentiallibrary/graphs/seriesdata/graphdatapoint.dart';
import '../../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';

class PlotSequencesUnitSizeScalerTests extends TestModule {
  late PlotSequencesUnitSizeScaler _scaler;
  late MockGraphSeriesExtentCalculator mockGraphSeriesExtentCalculator;
  late MockPlotSequencesRangeScaler mockPlotSequencesRangeScaler;
  var plotSequencesCalculatedRange = GraphSeriesExtent(1, 2, 3, 4);
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

    assertSameObject(mockGraphSeriesExtentCalculator.sequences, plotSequences);
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
    mockGraphSeriesExtentCalculator =
        MockGraphSeriesExtentCalculator(plotSequencesCalculatedRange);
    mockPlotSequencesRangeScaler =
        MockPlotSequencesRangeScaler(_scaledPlotSequences);
  }

  @override
  void setUpObjectUnderTest() {
    _scaler = PlotSequencesUnitSizeScaler(
        mockGraphSeriesExtentCalculator, mockPlotSequencesRangeScaler);
  }

  List<GraphDataSeries> creatPlotSequences() {
    return [
      GraphDataSeries([GraphDataPoint(100, 100)])
    ];
  }
}

class MockGraphSeriesExtentCalculator extends IGraphSeriesExtentCalculator {
  List<GraphDataSeries> sequences = List.empty();
  GraphSeriesExtent range;

  MockGraphSeriesExtentCalculator(this.range);

  @override
  GraphSeriesExtent calculateRange(List<GraphDataSeries> plotSequences) {
    sequences = plotSequences;
    return range;
  }
}

class MockPlotSequencesRangeScaler extends IPlotSequencesRangeScaler {
  List<GraphDataSeries> sequences = List.empty();
  late GraphSeriesExtent plotSequencesRange;
  late List<GraphDataSeries> _scaledPlotSequences;

  MockPlotSequencesRangeScaler(this._scaledPlotSequences);

  @override
  List<GraphDataSeries> scalePlotSequences(
      List<GraphDataSeries> plotSequences, GraphSeriesExtent range) {
    sequences = plotSequences;
    plotSequencesRange = range;
    return _scaledPlotSequences;
  }
}

//#endregion
