import 'package:ircommandmanager/dataobjects/tracepoint.dart';

class TracePoints {
  late List<TracePoint> points;

  TracePoints(Iterable<TracePoint> points) {
    points = points.toList();
  }

  static TracePoints fromJsonPoints(rawPoints) {
    var points = rawPoints
        .map((rp) => TracePoint.fromJsonPoint(rp))
        .toList()
        .cast<TracePoint>();
    return points;
  }
}
