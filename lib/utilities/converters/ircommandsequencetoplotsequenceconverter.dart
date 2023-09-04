import 'package:ircommandmanager/dataobjects/ircommand.dart';
import 'package:ircommandmanager/plotting/dataobjects/plotvalue.dart';
import '../../plotting/dataobjects/plotsequence.dart';

class IrCommandSequenceToPlotSequenceConverter {
  static PlotSequence convert(IrCommand command) {
    var values = command.points;
    List<PlotValue> plots = List.empty(growable: true);
    plots.add(PlotValue(values[0].time, values[0].value));
    var lastValue = values[0].value;

    for (var i = 1; i < values.length; i++) {
      plots.add(PlotValue(values[i].time, lastValue));
      plots.add(PlotValue(values[i].time, values[i].value));
      lastValue = values[i].value;
    }

    return PlotSequence(plots);
  }
}
