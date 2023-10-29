import '../../dataobjects/traces/tracepoint.dart';
import '../../dataobjects/traces/tracepoints.dart';
import '../../testframework/testmodule.dart';
import '../../testframework/testunit.dart';
import '../../utilities/tracepointstographdataseriesconverter.dart';

class TracePointsToGraphDataSeriesConverterTests extends TestModule {
  late TracePointsToGraphDataSeriesConverter _converter;

  @override
  void setUpObjectUnderTest() {
    _converter = TracePointsToGraphDataSeriesConverter();
  }

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aSimpleTraceIsConverted),
      createTest(aSequenceCanHaveNoElements),
    ];
  }

  void aSimpleTraceIsConverted() {
    var trace = createSimpleTrace();

    var series = _converter.convertTracePointsToGraphDataSeries(trace);
    var plot = series.plots;

    assertTrue(plot.length == 7);
    assertTrue(plot[0].x == 0);
    assertTrue(plot[0].y == 0);
    assertTrue(plot[1].x == 1);
    assertTrue(plot[1].y == 0);
    assertTrue(plot[2].x == 1);
    assertTrue(plot[2].y == 1);
    assertTrue(plot[3].x == 2);
    assertTrue(plot[3].y == 1);
    assertTrue(plot[4].x == 2);
    assertTrue(plot[4].y == 0);
    assertTrue(plot[5].x == 3);
    assertTrue(plot[5].y == 0);
    assertTrue(plot[6].x == 3);
    assertTrue(plot[6].y == 1);
  }

  void aSequenceCanHaveNoElements() {
    var commandSequence = TracePoints(List.empty(growable: false));

    var sequence =
        _converter.convertTracePointsToGraphDataSeries(commandSequence);
    var plots = sequence.plots;

    assertEqual(plots.length, 0);
  }

  TracePoints createSimpleTrace() {
    return createTrace([
      [0, 0],
      [1, 1],
      [2, 0],
      [3, 1]
    ]);
  }

  TracePoints createTrace(List<List<int>> list) {
    var points = list.map((p) => TracePoint(time: p[0], value: p[1]));
    return TracePoints(points);
  }
}
