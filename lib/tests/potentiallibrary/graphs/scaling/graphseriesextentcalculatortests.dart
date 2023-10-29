import '../../../../potentiallibrary/graphs/scaling/graphseriesextentcalculator.dart';
import '../../../../potentiallibrary/graphs/seriesdata/graphdatapoint.dart';
import '../../../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import '../../../../potentiallibrary/testframework/testmodule.dart';
import '../../../../potentiallibrary/testframework/testunit.dart';

class GraphSeriesExtentCalculatorTests extends TestModule {
  late GraphSeriesExtentCalculator _calculator;

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

    var range = _calculator.calculateRange(plotSequences);

    assertEqual(range.minx, 1.0);
    assertEqual(range.maxx, 3.0);
    assertEqual(range.miny, 2.0);
    assertEqual(range.maxy, 4.0);
  }

  void aComplexRangeCanBeFound() {
    var plotSequences = creatPlotSequencesltrb([
      [10, 10, 20, 20],
      [12, 5, 18, 25],
    ]);

    var range = _calculator.calculateRange(plotSequences);

    assertEqual(range.minx, 10.0);
    assertEqual(range.maxx, 20.0);
    assertEqual(range.miny, 5.0);
    assertEqual(range.maxy, 25.0);
  }

  void ifThereAreNoSequencesTheRangeIsZero() {
    var plotSequences = List<GraphDataSeries>.empty();

    var range = _calculator.calculateRange(plotSequences);

    assertEqual(range.minx, 0.0);
    assertEqual(range.maxx, 0.0);
    assertEqual(range.miny, 0.0);
    assertEqual(range.maxy, 0.0);
  }

  void ifASequenceHasNoPlotsItIsIgnored() {
    var plotSequences = creatPlotSequencesltrb([
      [10, 10, 20, 20],
      [12, 5, 18, 25],
    ]);
    plotSequences.add(GraphDataSeries(List<GraphDataPoint>.empty()));

    var range = _calculator.calculateRange(plotSequences);

    assertEqual(range.minx, 10.0);
    assertEqual(range.maxx, 20.0);
    assertEqual(range.miny, 5.0);
    assertEqual(range.maxy, 25.0);
  }

  void ifSeveralSequencesHaveNoPlotsTheRangeIsZero() {
    var plotSequences = [
      GraphDataSeries(List<GraphDataPoint>.empty()),
      GraphDataSeries(List<GraphDataPoint>.empty()),
      GraphDataSeries(List<GraphDataPoint>.empty()),
    ];

    var range = _calculator.calculateRange(plotSequences);

    assertEqual(range.minx, 0.0);
    assertEqual(range.maxx, 0.0);
    assertEqual(range.miny, 0.0);
    assertEqual(range.maxy, 0.0);
  }

  //#region Supporting Code

  @override
  void setUpObjectUnderTest() {
    _calculator = GraphSeriesExtentCalculator();
  }

  List<GraphDataSeries> creatPlotSequencesltrb(List<List<double>> values) {
    var seq = values.map((e) => GraphDataSeries([
          GraphDataPoint(e[0], e[1]),
          GraphDataPoint(e[2], e[1]),
          GraphDataPoint(e[2], e[3]),
          GraphDataPoint(e[0], e[1]),
        ]));
    return seq.toList();
  }
}

//#endregion
