import 'package:ircommandmanager/dataobjects/tracepoints.dart';
import '../dataobjects/tracerange.dart';

class TraceValueRangeFinder {
  TraceRange calculateRange(List<TraceDetails> traces) {
    var range = TraceRange();
    for (var trace in traces) {
      for (var point in trace.points) {
        if (point.time > range.maxx) {
          range.maxx = point.time;
        }
        if (point.value > range.maxy) {
          range.maxy = point.value;
        }
      }
    }
    return range;
  }
}
