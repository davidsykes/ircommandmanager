import 'package:flutter/material.dart';
import '../../../../dataobjects/ircommandsequence.dart';
import '../../../../plotting/view/plotwindow.dart';
import '../../../../utilities/converters/tracepointstographdataseriesconverter.dart';

class IrCommandsPlotWindow {
  late PlotWindow plotWindow;
  TracePointsToGraphDataSeriesConverter converter =
      TracePointsToGraphDataSeriesConverter();

  IrCommandsPlotWindow({required Listenable repaint}) {
    plotWindow = PlotWindow(repaint: repaint);
  }

  void showCommand(IrCommandSequence command) {
    var plot = converter.convertTracePointsToGraphDataSeries(command);
    plotWindow.setPlot(plot);
  }
}
