import '../../../plotting/dataobjects/plotsequence.dart';
import '../../../plotting/dataobjects/plotvalue.dart';
import '../../../plotting/logic/plotsequencesrangefinder.dart';
import '../../../testing/testmodule.dart';
import '../../../testing/testunit.dart';

class PlotSequencesRangeFinderTests extends TestModule {
  late PlotSequencesRangeFinder _finder;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aSimpleRangeCanBeFound),
      createTest(aComplexRangeCanBeFound),
      createTest(ifThereAreNoSequencesTheRangeIsZero),
      createTest(ifASequenceHasNoPlotsItIsIgnored),
      createTest(ifSeveralSequencesHaveNoPlotsTheRangeIsZero),
    ];
  }

  void aSimpleRangeCanBeFound() {
    var plotSequences = creatPlotSequencesltrb([
      [1, 2, 3, 4]
    ]);

    var range = _finder.calculateRange(plotSequences);

    assertEqual(range.minx, 1);
    assertEqual(range.maxx, 3);
    assertEqual(range.miny, 2);
    assertEqual(range.maxy, 4);
  }

  void aComplexRangeCanBeFound() {
    var plotSequences = creatPlotSequencesltrb([
      [10, 10, 20, 20],
      [12, 5, 18, 25],
    ]);

    var range = _finder.calculateRange(plotSequences);

    assertEqual(range.minx, 10);
    assertEqual(range.maxx, 20);
    assertEqual(range.miny, 5);
    assertEqual(range.maxy, 25);
  }

  void ifThereAreNoSequencesTheRangeIsZero() {
    var plotSequences = List<PlotSequence>.empty();

    var range = _finder.calculateRange(plotSequences);

    assertEqual(range.minx, 0);
    assertEqual(range.maxx, 0);
    assertEqual(range.miny, 0);
    assertEqual(range.maxy, 0);
  }

  void ifASequenceHasNoPlotsItIsIgnored() {
    var plotSequences = creatPlotSequencesltrb([
      [10, 10, 20, 20],
      [12, 5, 18, 25],
    ]);
    plotSequences.add(PlotSequence(List<PlotValue>.empty()));

    var range = _finder.calculateRange(plotSequences);

    assertEqual(range.minx, 10);
    assertEqual(range.maxx, 20);
    assertEqual(range.miny, 5);
    assertEqual(range.maxy, 25);
  }

  void ifSeveralSequencesHaveNoPlotsTheRangeIsZero() {
    var plotSequences = [
      PlotSequence(List<PlotValue>.empty()),
      PlotSequence(List<PlotValue>.empty()),
      PlotSequence(List<PlotValue>.empty()),
    ];

    var range = _finder.calculateRange(plotSequences);

    assertEqual(range.minx, 0);
    assertEqual(range.maxx, 0);
    assertEqual(range.miny, 0);
    assertEqual(range.maxy, 0);
  }

  //#region Supporting Code

  @override
  void setUpObjectUnderTest() {
    _finder = PlotSequencesRangeFinder();
  }

  List<PlotSequence> creatPlotSequencesltrb(List<List<int>> values) {
    var seq = values.map((e) => PlotSequence([
          PlotValue(e[0], e[1]),
          PlotValue(e[2], e[1]),
          PlotValue(e[2], e[3]),
          PlotValue(e[0], e[1]),
        ]));
    return seq.toList();
  }
}

//#endregion
