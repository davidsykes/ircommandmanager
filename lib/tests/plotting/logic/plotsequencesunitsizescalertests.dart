import '../../../plotting/dataobjects/plotsequence.dart';
import '../../../plotting/dataobjects/plotsequencesrange.dart';
import '../../../plotting/dataobjects/plotvalue.dart';
import '../../../plotting/logic/iplotsequencesrangefinder.dart';
import '../../../plotting/logic/iplotsequencesscaler.dart';
import '../../../plotting/logic/plotsequencesunitsizescaler.dart';
import '../../../testing/testmodule.dart';
import '../../../testing/testunit.dart';

class MockPlotSequencesRangeFinder extends IPlotSequencesRangeFinder {
  List<PlotSequence> sequences = List.empty();

  @override
  void calculateRange(List<PlotSequence> plotSequences) {
    sequences = plotSequences;
  }
}

class MockPlotSequencesScaler extends IPlotSequencesScaler {
  List<PlotSequence> sequences = List.empty();
  late PlotSequencesRange plotSequencesRange;
}

class PlotSequencesUnitSizeScalerTests extends TestModule {
  late PlotSequencesUnitSizeScaler _scaler;
  late MockPlotSequencesRangeFinder mockPlotSequencesRangeFinder;
  late MockPlotSequencesScaler mockPlotSequencesScaler;
  var plotSequencesCalculatedRange = PlotSequencesRange(1, 2, 3, 4);

  @override
  setUpMocks() {
    mockPlotSequencesRangeFinder = MockPlotSequencesRangeFinder();
    mockPlotSequencesScaler = MockPlotSequencesScaler();
  }

  @override
  void setUpObjectUnderTest() {
    _scaler = PlotSequencesUnitSizeScaler(mockPlotSequencesRangeFinder);
  }

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(plotSequencesArePassedToTheRangeFinder),
      createTest(plotSequencesArePassedToThePlotSequencesScaler),
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

    assertSameObject(mockPlotSequencesScaler.sequences, plotSequences);
    assertSameObject(mockPlotSequencesScaler.plotSequencesRange,
        plotSequencesCalculatedRange);
  }

  List<PlotSequence> creatPlotSequences() {
    return [
      PlotSequence([PlotValue(0, 0)])
    ];
  }
}
