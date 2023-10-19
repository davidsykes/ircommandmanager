import 'package:flutter/material.dart';
import 'graphdataseries.dart';
import 'graphwindowpainter.dart';

abstract class IGraphWindowManager {
  void addDataSeries(List<GraphDataSeries> series) {}
}

class GraphWindowManager extends StatefulWidget implements IGraphWindowManager {
  @override
  State<GraphWindowManager> createState() => _GraphWindowManagerState();
  @override
  void addDataSeries(List<GraphDataSeries> series) {
    // TODO: implement dos
  }
}

class _GraphWindowManagerState extends State<GraphWindowManager> {
  var graphWindowPainter = GraphWindowPainter();

  @override
  Widget build(BuildContext context) {
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
