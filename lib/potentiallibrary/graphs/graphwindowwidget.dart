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
        ButtonBar(alignment: MainAxisAlignment.start, children: [
          Text('Zoom'),
          Slider(
              value: widget._graphWindowData.zoom.toDouble() * 4,
              min: 4,
              max: 100,
              label: widget._graphWindowData.zoom.toString(),
              onChanged: (double value) {
                setState(() {
                  widget._graphWindowData.zoom = (value / 4).round();
                });
              }),
          Text('Pan'),
          Slider(
              value: widget._graphWindowData.offset.toDouble(),
              min: 0,
              max: 99,
              label: widget._graphWindowData.offset.toString(),
              onChanged: (double value) {
                setState(() {
                  widget._graphWindowData.offset = value.round();
                });
              }),
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
