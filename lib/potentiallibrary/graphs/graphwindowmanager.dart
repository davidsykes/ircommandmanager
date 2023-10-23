import 'package:flutter/material.dart';
import 'scaling/graphseriesextentcalculator.dart';
import 'seriesdata/graphdataseries.dart';
import 'graphwindowdata.dart';
import 'graphwindowpainter.dart';

abstract class IGraphWindowManager {
  void addDataSeries(Iterable<GraphDataSeries> series) {}
}

class GraphWindowManager extends StatefulWidget implements IGraphWindowManager {
  final graphWindowData = GraphWindowData();
  final _graphSeriesExtentCalculator = GraphSeriesExtentCalculator();

  @override
  State<GraphWindowManager> createState() => _GraphWindowManagerState();

  @override
  void addDataSeries(Iterable<GraphDataSeries> serieses) {
    for (final series in serieses) {
      graphWindowData.seriesToDisplay.add(series);
    }
    _recalculateGraphSeriesExtent();
  }

  void _recalculateGraphSeriesExtent() {
    graphWindowData.graphSeriesExtent = _graphSeriesExtentCalculator
        .calculateRange(graphWindowData.seriesToDisplay);
  }
}

class _GraphWindowManagerState extends State<GraphWindowManager> {
  @override
  Widget build(BuildContext context) {
    var graphWindowPainter = GraphWindowPainter(widget.graphWindowData);
    return Column(
      children: [
        OverflowBar(alignment: MainAxisAlignment.start, children: [
          Text('Controls'),
          Text('Controls'),
        ]),
        Expanded(
            child: CustomPaint(
          size: Size.infinite,
          painter: graphWindowPainter,
        ))
      ],
    );
  }
}
