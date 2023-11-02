import '../dataobjects/traces/tracepoint.dart';
import 'wavedefinitionfrompico.dart';

abstract class ITraceToIrWaveDefinitionFromPicoConverter {
  WaveDefinitionFromPico convert(String name, List<TracePoint> points);
}

class TraceToIrWaveDefinitionFromPicoConverter
    extends ITraceToIrWaveDefinitionFromPicoConverter {
  @override
  WaveDefinitionFromPico convert(String name, List<TracePoint> points) {
    if (points.length < 2) {
      return _makeEmptyCode(name);
    }

    points = _removeInitialValue(points);
    var wavepoints = List<List<int>>.empty(growable: true);
    var lastTime = 0;
    for (final point in points) {
      var deltaTime = point.time - lastTime;
      var value = point.value >= 128 ? 0 : 1;
      wavepoints.add([deltaTime, value]);
      lastTime = point.time;
    }

    var code = WaveDefinitionFromPico();
    code.code = name;
    code.wavepoints = wavepoints;
    return code;
  }

  List<TracePoint> _removeInitialValue(List<TracePoint> points) {
    return points.sublist(1);
  }

  WaveDefinitionFromPico _makeEmptyCode(String name) {
    var code = WaveDefinitionFromPico();
    code.code = name;
    code.wavepoints = List.empty();
    return code;
  }
}
