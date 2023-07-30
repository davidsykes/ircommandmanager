import 'package:flutter/material.dart';
import 'package:ircommandmanager/utilities/tracetolinesconverter.dart';
import 'dataobjects/plotviewcontrolvariables.dart';
import 'dataobjects/traceinfo.dart';
import 'dart:ui' as ui;
import 'utilities/scalinghelper.dart';

class MyPainter extends CustomPainter {
  final PlotViewControlVariables plotViewControlVariables;
  final List<TraceInfo> traces;

  MyPainter({required this.plotViewControlVariables, required this.traces});

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

    if (plotViewControlVariables.showTestPlot) {
      drawTestPattern(canvas, size, paint);
    }

    drawTracesUsingUnscaledCanvas(canvas, size, paint);
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

  void drawTracesUsingUnscaledCanvas(Canvas canvas, Size size, Paint paint) {
    var scalingHelper = ScalingHelper(
        screenWidth: size.width,
        screenHeight: size.height,
        zoom: plotViewControlVariables.zoom,
        offset: plotViewControlVariables.offset);

    var tracesToPlot = traces
        .map((t) => TraceToLinesConverter().convertTraceToPlot(t.traceDetails!))
        .toList();

    var maxX = scalingHelper.getMaximumXValue(tracesToPlot);

    for (var plot in tracesToPlot) {
      plotTrace(plot, scalingHelper, maxX, canvas, paint);
    }
  }

  List<Offset> convertToOffsets(plot) {
    var offsets = plot.map((p) => Offset(p[0], p[1])).toList().cast<Offset>();
    return offsets;
  }

  void plotTrace(List<List<double>> plot, ScalingHelper scalingHelper,
      double maxX, Canvas canvas, Paint paint) {
    var scaled = scalingHelper.scaleToHorizontalExtent(plot: plot, maxX: maxX);

    var offsets = convertToOffsets(scaled);
    canvas.drawPoints(ui.PointMode.polygon, offsets, paint);
  }
}
