import '../dataobjects/traces/tracepoints.dart';

class CodeToBeConverted {
  TracePoints? _tracePoints;
  void setCodeForConversion(TracePoints tracePoints) {
    _tracePoints = tracePoints;
  }

  TracePoints getTracePoints() {
    if (_tracePoints == null) {
      return TracePoints(List.empty());
    }
    return _tracePoints!;
  }
}
