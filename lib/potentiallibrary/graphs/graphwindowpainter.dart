import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'graphwindowdata.dart';

class GraphWindowPainter extends CustomPainter {
  final GraphWindowData graphWindowData;

  GraphWindowPainter(this.graphWindowData);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.butt;

    drawTestPattern(canvas, size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void drawTestPattern(Canvas canvas, Size size, Paint paint) {
    var canvasWidth = size.width;
    var canvasHeight = size.height;
    final points = [
      Offset(0, 0),
      Offset(canvasWidth, 0),
      Offset(canvasWidth, canvasHeight),
      Offset(0, canvasHeight),
      Offset(0, 0),
      Offset(canvasWidth, canvasHeight),
      Offset(0, canvasHeight),
      Offset(canvasWidth, 0),
    ];
    canvas.drawPoints(ui.PointMode.polygon, points, paint);
  }
}
