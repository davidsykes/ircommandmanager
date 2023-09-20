import 'package:flutter/material.dart';
import '../../../../dataobjects/ircommandsequence.dart';
import '../../../../plotting/view/plotwindow.dart';
import '../../../../utilities/converters/ircommandsequencetoplotsequenceconverter.dart';

class IrCommandsPlotWindow {
  late PlotWindow plotWindow;
  IrCommandSequenceToPlotSequenceConverter converter =
      IrCommandSequenceToPlotSequenceConverter();

  IrCommandsPlotWindow({required Listenable repaint}) {
    plotWindow = PlotWindow(repaint: repaint);
  }

  void showCommand(IrCommandSequence command) {
    var plot = converter.convert(command);
    plotWindow.setPlot(plot);
  }
}
