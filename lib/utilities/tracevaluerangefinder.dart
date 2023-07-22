import 'package:ircommandmanager/dataobjects/tracepoints.dart';
import '../dataobjects/tracerange.dart';

class TraceValueRangeFinder {
  TraceRange calculateRange(List<TracePoints> traces) {
    var range = TraceRange();
    for (var trace in traces) {
      for (var point in trace.points) {
        if (point.time < range.minx) {
          range.minx = point.time;
        }
        if (point.time > range.maxx) {
          range.maxx = point.time;
        }
        if (point.value < range.miny) {
          range.miny = point.value;
        }
        if (point.value > range.maxy) {
          range.maxy = point.value;
        }
      }
    }
    return range;
  }
}
