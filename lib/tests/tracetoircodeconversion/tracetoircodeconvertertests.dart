import '../../dataobjects/traces/tracepoint.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../tracetoircodeconversion/tracetoircodeconverter.dart';

class TraceToIrCodeConverterTests extends TestModule {
  late ITraceToIrCodeConverter _converter;

  @override
  void setUpObjectUnderTest() {
    _converter = TraceToIrCodeConverter();
  }

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aSimpleTraceIsConverted),
      createTest(aSequenceCanHaveNoElements),
      createTest(aSingleElementIsConsideredEmpty),
    ];
  }

  void aSimpleTraceIsConverted() {
    var trace = createTrace([
      [0, 255],
      [0, 127],
      [10, 255],
      [20, 127],
      [30, 255],
      [40, 127],
    ]);

    var code = _converter.convert('name', trace);
    var points = code.wavepoints;

    assertEqual(code.code, 'name');
    assertTrue(points.length == 5);
    assertTrue(points[0][0] == 0);
    assertTrue(points[0][1] == 1);
    assertTrue(points[1][0] == 10);
    assertTrue(points[1][1] == 0);
    assertTrue(points[2][0] == 20);
    assertTrue(points[2][1] == 1);
    assertTrue(points[3][0] == 30);
    assertTrue(points[3][1] == 0);
    assertTrue(points[4][0] == 40);
    assertTrue(points[4][1] == 1);
  }

  void aSequenceCanHaveNoElements() {
    var trace = List<TracePoint>.empty(growable: false);

    var code = _converter.convert('name', trace);
    var points = code.wavepoints;

    assertEqual(points.length, 0);
  }

  void aSingleElementIsConsideredEmpty() {
    var trace = createTrace([
      [0, 255],
    ]);

    var code = _converter.convert('name', trace);
    var points = code.wavepoints;

    assertEqual(points.length, 0);
  }

  Iterable<TracePoint> createTrace(List<List<int>> list) {
    var points = list.map((p) => TracePoint(time: p[0], value: p[1]));
    return points;
  }
}
