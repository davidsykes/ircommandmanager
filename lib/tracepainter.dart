import 'package:flutter/material.dart';
import 'dataobjects/traceinfo.dart';
import 'dart:ui' as ui;

class MyPainter extends CustomPainter {
  final List<TraceInfo> traces;

  MyPainter({required this.traces});

  @override
  void paint(Canvas canvas, Size size) {
    //canvas.translate(0, -size.height);
    //canvas.scale(0.2, 0.2);

    var canvasWidth = size.width;
    var canvasHeight = size.height;

    const pointMode = ui.PointMode.polygon;
    final points = [
      Offset(0, 0),
      Offset(canvasWidth, 0),
      Offset(canvasWidth, canvasHeight),
      Offset(0, canvasHeight),
      Offset(0, 0),
    ];
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);

    var offsets = traces[0]
        .traceDetails!
        .points
        .map((rp) => Offset(rp.time.toDouble(), rp.value.toDouble()))
        .toList()
        .cast<Offset>();

    canvas.drawPoints(pointMode, offsets, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
