import '../../../plotting/dataobjects/plotsequence.dart';
import '../../../plotting/dataobjects/plotsequencesrange.dart';
import '../../../plotting/dataobjects/plotvalue.dart';
import '../../../plotting/logic/iplotsequencesrangefinder.dart';
import '../../../plotting/logic/iplotsequencesrangescaler.dart';
import '../../../plotting/logic/plotsequencesunitsizescaler.dart';
import '../../../testframework/testmodule.dart';
import '../../../testframework/testunit.dart';

class PlotSequencesUnitSizeScalerTests extends TestModule {
  late PlotSequencesUnitSizeScaler _scaler;
  late MockPlotSequencesRangeFinder mockPlotSequencesRangeFinder;
  late MockPlotSequencesRangeScaler mockPlotSequencesRangeScaler;
  var plotSequencesCalculatedRange = PlotSequencesRange(1, 2, 3, 4);
  late List<PlotSequence> _scaledPlotSequences;

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
      PlotSequence([PlotValue(1, 2)])
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

  List<PlotSequence> creatPlotSequences() {
    return [
      PlotSequence([PlotValue(100, 100)])
    ];
  }
}

class MockPlotSequencesRangeFinder extends IPlotSequencesRangeFinder {
  List<PlotSequence> sequences = List.empty();
  PlotSequencesRange range;

  MockPlotSequencesRangeFinder(this.range);

  @override
  PlotSequencesRange calculateRange(List<PlotSequence> plotSequences) {
    sequences = plotSequences;
    return range;
  }
}

class MockPlotSequencesRangeScaler extends IPlotSequencesRangeScaler {
  List<PlotSequence> sequences = List.empty();
  late PlotSequencesRange plotSequencesRange;
  late List<PlotSequence> _scaledPlotSequences;

  MockPlotSequencesRangeScaler(this._scaledPlotSequences);

  @override
  List<PlotSequence> scalePlotSequences(
      List<PlotSequence> plotSequences, PlotSequencesRange range) {
    sequences = plotSequences;
    plotSequencesRange = range;
    return _scaledPlotSequences;
  }
}

//#endregion
