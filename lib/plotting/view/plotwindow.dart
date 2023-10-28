import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../potentiallibrary/graphs/scaling/graphseriesextentcalculator.dart';
import '../../potentiallibrary/graphs/seriesdata/graphdatapoint.dart';
import '../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import '../logic/iplotsequencesunitsizescaler.dart';
import '../logic/plotsequencerangescaler.dart';
import '../logic/plotsequencesrangescaler.dart';
import '../logic/plotsequencesunitsizescaler.dart';
import '../logic/plotviewport.dart';
import 'plotviewcontrolvariables.dart';

// TODO This is to go

class PlotWindow extends CustomPainter {
  List<GraphDataSeries> plotSequences = List.empty();
  List<GraphDataSeries> unitPlots = List.empty();

  late IPlotSequencesUnitSizeScaler _scaler;
  var _plotViewport = PlotViewport();

  PlotWindow({required Listenable repaint}) : super(repaint: repaint) {
    var plotSequencesRangeFinder = GraphSeriesExtentCalculator();
    var plotSequenceRangeScaler = PlotSequenceRangeScaler();
    var plotSequencesRangeScaler =
        PlotSequencesRangeScaler(plotSequenceRangeScaler);
    _scaler = PlotSequencesUnitSizeScaler(
        plotSequencesRangeFinder, plotSequencesRangeScaler);
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

  void setPlot(GraphDataSeries plot) {
    plotSequences = [plot];
    scalePlotsToUnitSize();
  }

  void scalePlotsToUnitSize() {
    unitPlots = _scaler.scaleToUnitSize(plotSequences);
  }

  void drawPlots(Canvas canvas, Size size, Paint paint) {
    for (var plot in unitPlots) {
      plotTrace(canvas, size, paint, plot);
    }
  }

  void plotTrace(
      Canvas canvas, Size size, Paint paint, GraphDataSeries plotSequence) {
    var plots = plotSequence.plots;
    plots = _plotViewport.scaleToViewport(plots, size.width, size.height);
    var offsets = convertToOffsets(plots);
    canvas.drawPoints(ui.PointMode.polygon, offsets, paint);
  }

  List<Offset> convertToOffsets(List<GraphDataPoint> plots) {
    var offsets = plots.map((p) => Offset(p.x, p.y)).toList().cast<Offset>();
    return offsets;
  }
}
