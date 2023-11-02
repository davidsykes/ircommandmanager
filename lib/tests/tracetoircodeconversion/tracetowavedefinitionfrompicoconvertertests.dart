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
      [0, 255],
      [0, 127],
      [10, 255],
      [20, 127],
      [30, 255],
      [40, 127],
      [100, 255],
      [200, 127],
      [1000, 255],
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
