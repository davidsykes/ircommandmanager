import 'package:flutter/material.dart';
import 'package:ircommandmanager/utilities/tracetolinesconverter.dart';
import 'package:ircommandmanager/utilities/tracevaluerangefinder.dart';
import 'dataobjects/traceinfo.dart';
import 'dart:ui' as ui;

import 'dataobjects/tracepoints.dart';

class MyPainter extends CustomPainter {
  final List<TraceInfo> traces;

  MyPainter({required this.traces});

  @override
  void paint(Canvas canvas, Size size) {
    //canvas.translate(0, -size.height);
    //canvas.scale(0.2, 0.2);
    //var canvasWidth = size.width;
    //var canvasHeight = size.height;

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.butt;

    drawTestPattern(canvas, size, paint);

    var tracesToPlot =
        traces.map((t) => t.traceDetails!).cast<TracePoints>().toList();

    var range = TraceValueRangeFinder().calculateRange(tracesToPlot);

    var scalex = size.width / range.maxx;
    var scaley = size.height / range.maxy;
    canvas.scale(scalex, scaley);

    drawTrace(traces[0], canvas, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
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

  void drawTrace(TraceInfo trace, Canvas canvas, Paint paint) {
    var traceAsLines =
        TraceToLinesConverter().convertTraceToPlot(trace.traceDetails!);

    var offsets = traceAsLines
        .map((p) => Offset(p.x.toDouble(), p.y.toDouble()))
        .toList()
        .cast<Offset>();

    canvas.drawPoints(ui.PointMode.polygon, offsets, paint);
  }
}
