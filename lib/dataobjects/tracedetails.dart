import 'dart:ui';

class TraceDetails {
  late List<Offset> points;

  TraceDetails(rawPoints) {
    points = rawPoints
        .map((rp) => Offset(rp['time'].toDouble(), rp['value'].toDouble()))
        .toList()
        .cast<Offset>();
  }
}
