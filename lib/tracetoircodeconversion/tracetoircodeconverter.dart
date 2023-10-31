import '../dataobjects/traces/tracepoint.dart';
import 'wavedefinitionfrompico.dart';

abstract class ITraceToIrCodeConverter {
  WaveDefinitionFromPico convert(String name, Iterable<TracePoint> points);
}

class TraceToIrCodeConverter extends ITraceToIrCodeConverter {
  @override
  WaveDefinitionFromPico convert(String name, Iterable<TracePoint> points) {
    var code = WaveDefinitionFromPico();
    code.code = name;
    if (points.length > 1) {
      code.wavepoints = points
          .map((e) => [e.time, e.value >= 128 ? 0 : 1])
          .toList()
          .sublist(1);
    } else {
      code.wavepoints = List.empty();
    }
    return code;
  }
}
