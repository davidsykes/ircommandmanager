import 'package:ircommandmanager/tracetoircodeconversion/wavedefinitionfrompico.dart';

import '../../dataobjects/traces/tracepoint.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../tracetoircodeconversion/tracetowavedefinitionfrompicoconverter.dart';

class TraceToIrCodeConverterTests extends TestModule {
  late ITraceToIrWaveDefinitionFromPicoConverter _converter;

  @override
  void setUpObjectUnderTest() {
    _converter = TraceToIrWaveDefinitionFromPicoConverter();
  }

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aTraceIsConvertedToAnIrCode),
      createTest(aSequenceCanHaveNoElements),
      createTest(aSingleElementIsConsideredEmpty),
    ];
  }

  void aTraceIsConvertedToAnIrCode() {
    var trace = createTrace([
      [0, 0],
      [0, 1],
      [10, 0],
      [20, 1],
      [30, 0],
      [40, 1],
      [100, 0],
      [200, 1],
      [1000, 0],
    ]);

    var expecteWave = createWave([
      [0, 1],
      [10, 0],
      [10, 1],
      [10, 0],
      [10, 1],
      [60, 0],
      [100, 1],
      [800, 0]
    ]);

    var code = _converter.convert('name', trace);
    //var points = code.wavepoints;

    assertEqual(expecteWave, code);
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

  List<TracePoint> createTrace(List<List<int>> list) {
    var points = list.map((p) => TracePoint(time: p[0], value: p[1]));
    return points.toList();
  }

  WaveDefinitionFromPico createWave(List<List<int>> wavepoints) {
    var wd = WaveDefinitionFromPico();
    wd.code = 'name';
    wd.wavepoints = wavepoints;
    return wd;
  }
}
