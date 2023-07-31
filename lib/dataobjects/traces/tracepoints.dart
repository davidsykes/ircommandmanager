import 'tracepoint.dart';

class TracePoints {
  late List<TracePoint> points;

  TracePoints(Iterable<TracePoint> iterablePoints) {
    points = iterablePoints.toList();
  }

  static TracePoints fromJsonPoints(rawPoints) {
    var points1 = rawPoints.map((rp) => TracePoint.fromJsonPoint(rp));
    var points2 = points1.toList().cast<TracePoint>();
    return TracePoints(points2);
  }
}
