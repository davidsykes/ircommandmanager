import '../../dataobjects/traces/tracepoint.dart';
import '../../dataobjects/traces/tracepoints.dart';
import '../../testing/testmodule.dart';
import '../../testing/testunit.dart';
import '../../utilities/ircommandsequencetoplotsequenceconverter.dart';

class TraceToLinesConverterTests extends TestModule {
  late IrCommandSequenceToPlotSequenceConverter _converter;

  @override
  void setUpObjectUnderTest() {
    _converter = IrCommandSequenceToPlotSequenceConverter();
  }

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aSimpleTraceIsConverted),
    ];
  }

  void aSimpleTraceIsConverted() {
    var trace = createSimpleTrace();

    var plot = _converter.convertTraceToPlot(trace);

    myAssert(plot.length == 7);
    myAssert(plot[0][0] == 0);
    myAssert(plot[0][1] == 0);
    myAssert(plot[1][0] == 1);
    myAssert(plot[1][1] == 0);
    myAssert(plot[2][0] == 1);
    myAssert(plot[2][1] == 1);
    myAssert(plot[3][0] == 2);
    myAssert(plot[3][1] == 1);
    myAssert(plot[4][0] == 2);
    myAssert(plot[4][1] == 0);
    myAssert(plot[5][0] == 3);
    myAssert(plot[5][1] == 0);
    myAssert(plot[6][0] == 3);
    myAssert(plot[6][1] == 1);
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
