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
    ];
  }

  void aSimpleTraceIsConverted() {
    var trace = createSimpleTrace();

    var series = _converter.convertTracePointsToGraphDataSeries(trace);
    var plot = series.data;

    assertTrue(plot.length == 7);
    assertTrue(plot[0][0] == 0);
    assertTrue(plot[0][1] == 0);
    assertTrue(plot[1][0] == 1);
    assertTrue(plot[1][1] == 0);
    assertTrue(plot[2][0] == 1);
    assertTrue(plot[2][1] == 1);
    assertTrue(plot[3][0] == 2);
    assertTrue(plot[3][1] == 1);
    assertTrue(plot[4][0] == 2);
    assertTrue(plot[4][1] == 0);
    assertTrue(plot[5][0] == 3);
    assertTrue(plot[5][1] == 0);
    assertTrue(plot[6][0] == 3);
    assertTrue(plot[6][1] == 1);
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
