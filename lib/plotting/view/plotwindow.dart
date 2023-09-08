import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../dataobjects/plotsequence.dart';
import '../logic/iplotsequencesunitsizescaler.dart';
import '../logic/plotsequencesrangefinder.dart';
import '../logic/plotsequencesunitsizescaler.dart';
import 'plotviewcontrolvariables.dart';

class PlotWindow extends CustomPainter {
  List<PlotSequence> plotSequences = List.empty();
  List<PlotSequence> unitPlots = List.empty();

  late IPlotSequencesUnitSizeScaler _scaler;

  PlotWindow({required Listenable repaint}) : super(repaint: repaint) {
    var plotSequencesRangeFinder = PlotSequencesRangeFinder();
    _scaler = PlotSequencesUnitSizeScaler(plotSequencesRangeFinder);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.scale(1, -1);

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.butt;

    var pvcv = PlotViewControlVariables();

    if (pvcv.showTestPlot) {
      drawTestPattern(canvas, size, paint);
    }

    drawPlots(canvas, size, paint);
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
      Offset(0, 0),
      Offset(canvasWidth / 2, canvasHeight / 4),
      Offset(canvasWidth / 3, canvasHeight / 4),
      Offset(canvasWidth / 2, canvasHeight / 4),
      Offset(canvasWidth / 2, canvasHeight / 5),
    ];
    canvas.drawPoints(ui.PointMode.polygon, points, paint);
  }

  void setPlot(PlotSequence plot) {
    plotSequences = [plot];
    scalePlotsToUnitSize();
  }

  void scalePlotsToUnitSize() {
    unitPlots = _scaler.scaleToUnitSize(plotSequences);
  }

  void drawPlots(Canvas canvas, Size size, Paint paint) {
    //   var horizontalScaler = TraceHorizontalScaler(
    //       screenWidth: size.width,
    //       zoom: plotViewControlVariables.zoom,
    //       offset: plotViewControlVariables.offset);

    //   var verticalScaler = TraceVerticalScaler(
    //       screenHeight: size.height, traceCount: traces.length);

    //   var tracesToPlot = traces
    //       .map((t) => IrCommandSequenceToPlotSequenceConverter()
    //           .convertTraceToPlot(t.traceDetails!))
    //       .toList();

    //   var maxX = horizontalScaler.getMaximumXValue(tracesToPlot);

    for (var plot in unitPlots) {
      //     plotTrace(plot, horizontalScaler, maxX, verticalScaler, canvas, paint);
    }
  }

  // void plotTrace(
  //     List<List<double>> plot,
  //     TraceHorizontalScaler horizontalScaler,
  //     double maxX,
  //     TraceVerticalScaler traceVerticalScaler,
  //     Canvas canvas,
  //     Paint paint) {
  //   var scaled =
  //       horizontalScaler.scaleToHorizontalExtent(plot: plot, maxX: maxX);

  //   scaled = horizontalScaler.scalePlotValuesToUnitRange(scaled);

  //   scaled = traceVerticalScaler.scalePlot(0, scaled);

  //   var offsets = convertToOffsets(scaled);
  //   canvas.drawPoints(ui.PointMode.polygon, offsets, paint);
  // }

  // List<Offset> convertToOffsets(plot) {
  //   var offsets = plot.map((p) => Offset(p[0], p[1])).toList().cast<Offset>();
  //   return offsets;
  // }
}
