import 'package:ircommandmanager/dataobjects/ircommandsequence.dart';
import 'package:ircommandmanager/plotting/dataobjects/plotvalue.dart';
import '../../plotting/dataobjects/plotsequence.dart';

class IrCommandSequenceToPlotSequenceConverter {
  PlotSequence convert(IrCommandSequence command) {
    List<PlotValue> plots = List.empty(growable: true);

    var values = command.values;
    if (values.isNotEmpty) {
      plots.add(
          PlotValue(values[0].time.toDouble(), values[0].value.toDouble()));
      var lastValue = values[0].value.toDouble();

      for (var i = 1; i < values.length; i++) {
        plots.add(PlotValue(values[i].time.toDouble(), lastValue));
        plots.add(
            PlotValue(values[i].time.toDouble(), values[i].value.toDouble()));
        lastValue = values[i].value.toDouble();
      }
    }

    return PlotSequence(plots);
  }
}
