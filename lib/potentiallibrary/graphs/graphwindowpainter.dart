import 'package:flutter/material.dart';
import 'package:ircommandmanager/potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import 'dart:ui' as ui;
import 'graphwindowdata.dart';

class GraphWindowPainter extends CustomPainter {
  final GraphWindowData graphWindowData;

  GraphWindowPainter(this.graphWindowData);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.scale(1, -1);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.butt;

    //drawTestPattern(canvas, size, paint);

    for (var series in graphWindowData.dataSeries) {
      if (series.enable) {
        _plotSeries(series, canvas, size, paint);
      }
    }
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
      Offset(0, 0),
      Offset(canvasWidth / 2, canvasHeight / 4),
      Offset(canvasWidth / 3, canvasHeight / 4),
      Offset(canvasWidth / 2, canvasHeight / 4),
      Offset(canvasWidth / 2, canvasHeight / 5),
    ];
    canvas.drawPoints(ui.PointMode.polygon, points, paint);
  }

  void _plotSeries(
      GraphDataSeries series, Canvas canvas, Size size, Paint paint) {
    var el = graphWindowData.graphSeriesExtent.minx;
    var er = graphWindowData.graphSeriesExtent.maxx;
    var et = graphWindowData.graphSeriesExtent.maxy;
    var eb = graphWindowData.graphSeriesExtent.miny;
    var vl = 0;
    var vr = 1;
    var vb = 0;
    var vt = 1;
    var cw = size.width;
    var ch = size.height;
    var bw = 0.05;
    double lx = 0;
    double ly = 0;
    bool firstPoint = true;
    for (var point in series.plots) {
      var x = point.x;
      var y = point.y;
      var xa = (x - el) / (er - el);
      xa = includeZoomAndPan(xa);
      var xb = (xa - vl) / (vr - vl);
      var xc = (xb * (1 - bw * 2) + bw) * cw;
      var ya = (y - eb) / (et - eb);
      var yb = (ya - vb) / (vt - vb);
      var yc = (yb * (1 - bw * 2) + bw) * ch;

      if (firstPoint) {
        firstPoint = false;
      } else {
        final points = [Offset(lx, ly), Offset(xc, yc)];
        canvas.drawPoints(ui.PointMode.polygon, points, paint);
      }
      lx = xc;
      ly = yc;
    }
  }

  double includeZoomAndPan(double xa) {
    var zoom = graphWindowData.zoom;
    var pan = graphWindowData.offset / 100.0;
    return (xa - pan) * zoom;
  }
}
