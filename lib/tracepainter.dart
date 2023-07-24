import 'package:flutter/material.dart';
import 'package:ircommandmanager/utilities/tracetolinesconverter.dart';
import 'package:ircommandmanager/utilities/tracevaluerangefinder.dart';
import 'dataobjects/traceinfo.dart';
import 'dart:ui' as ui;
import 'dataobjects/tracepoints.dart';
import 'utilities/scalinghelper.dart';

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

    drawTracesUsingUnscaledCanvas(canvas, size, paint);

    drawTracesUsingScaledCanvas(canvas, size, paint);
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

    var offsets =
        traceAsLines.map((p) => Offset(p[0], p[1])).toList().cast<Offset>();

    canvas.drawPoints(ui.PointMode.polygon, offsets, paint);
  }

  void drawTracesUsingScaledCanvas(Canvas canvas, Size size, Paint paint) {
    var tracesToPlot =
        traces.map((t) => t.traceDetails!).cast<TracePoints>().toList();

    var range = TraceValueRangeFinder().calculateRange(tracesToPlot);

    var scalex = size.width / range.maxx;
    var scaley = size.height / range.maxy;
    canvas.scale(scalex, scaley);

    drawTrace(traces[0], canvas, paint);
  }

  void drawTracesUsingUnscaledCanvas(Canvas canvas, Size size, Paint paint) {
    var scalingHelper =
        ScalingHelper(screenWidth: size.width, screenHeight: size.height);

    var plots = traces
        .map((t) => TraceToLinesConverter().convertTraceToPlot(t.traceDetails!))
        .toList();

    var maxY = scalingHelper.getMaximumYValue(plots);

    for (var plot in plots) {
      var scaled1 =
          scalingHelper.scaleToHorizontalExtent(plot: plot, maxY: maxY);

      var offsets = convertToOffsets(scaled1);
      canvas.drawPoints(ui.PointMode.polygon, offsets, paint);
    }
  }

  List<Offset> convertToOffsets(plot) {
    var offsets = plot.map((p) => Offset(p[0], p[1])).toList().cast<Offset>();
    return offsets;
  }
}
