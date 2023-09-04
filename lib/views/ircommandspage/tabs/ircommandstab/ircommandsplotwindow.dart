import 'package:ircommandmanager/dataobjects/ircommandsequence.dart';
import '../../../../plotting/view/plotwindow.dart';
import '../../../../utilities/converters/ircommandsequencetoplotsequenceconverter.dart';

class IrCommandsPlotWindow {
  //One instance, needs factory
  static IrCommandsPlotWindow? _instance;
  factory IrCommandsPlotWindow() => _instance ??= IrCommandsPlotWindow._();
  IrCommandsPlotWindow._();

  PlotWindow plotWindow = PlotWindow();
  IrCommandSequenceToPlotSequenceConverter converter =
      IrCommandSequenceToPlotSequenceConverter();

  void showCommand(IrCommandSequence command) {
    var plot = converter.convert(command);
    plotWindow.setPlot(plot);
  }
}
