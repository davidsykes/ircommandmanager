import 'package:ircommandmanager/dataobjects/tracepoint.dart';

class TraceDetails {
  late List<TracePoint> points;

  TraceDetails(rawPoints) {
    points = rawPoints.map((rp) => TracePoint(rp)).toList();
  }
}
