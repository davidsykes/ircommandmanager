import 'package:flutter/material.dart';
import 'seriesdata/graphdataseries.dart';
import 'graphwindowdata.dart';
import 'graphwindowpainter.dart';

abstract class IGraphWindowWidget {
  void addDataSeries(Iterable<GraphDataSeries> series) {}
}

class GraphWindowWidget extends StatefulWidget implements IGraphWindowWidget {
  final _graphWindowData = GraphWindowData();

  @override
  State<GraphWindowWidget> createState() => _GraphWindowWidgetState();

  @override
  void addDataSeries(Iterable<GraphDataSeries> serieses) {
    _graphWindowData.addMultipleSeries(serieses);
  }
}

class _GraphWindowWidgetState extends State<GraphWindowWidget> {
  @override
  Widget build(BuildContext context) {
    var graphWindowPainter = GraphWindowPainter(widget._graphWindowData);
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
