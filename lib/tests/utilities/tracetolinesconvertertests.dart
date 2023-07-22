import '../../dataobjects/tracepoint.dart';
import '../../dataobjects/tracepoints.dart';
import '../../testing/testmodule.dart';
import '../../testing/testunit.dart';
import '../../utilities/tracetolinesconverter.dart';

class TraceToLinesConverterTests extends TestModule {
  late TraceToLinesConverter _converter;

  @override
  void setUpObjectUnderTest() {
    _converter = TraceToLinesConverter();
  }

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest('A simple trace is converted', aSimpleTraceIsConverted),
    ];
  }

  void aSimpleTraceIsConverted() {
    var trace = createSimpleTrace();

    var plot = _converter.convertTraceToPlot(trace);

    myAssert(plot.length == 7);
    myAssert(plot[0].x == 0);
    myAssert(plot[0].y == 0);
    myAssert(plot[1].x == 1);
    myAssert(plot[1].y == 0);
    myAssert(plot[2].x == 1);
    myAssert(plot[2].y == 1);
    myAssert(plot[3].x == 2);
    myAssert(plot[3].y == 1);
    myAssert(plot[4].x == 2);
    myAssert(plot[4].y == 0);
    myAssert(plot[5].x == 3);
    myAssert(plot[5].y == 0);
    myAssert(plot[6].x == 3);
    myAssert(plot[6].y == 1);
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
    var points = list.map((p) => TracePoint(p[0], p[1]));
    return TracePoints(points);
  }
}
