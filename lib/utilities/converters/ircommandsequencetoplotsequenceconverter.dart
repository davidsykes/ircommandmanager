import 'package:ircommandmanager/dataobjects/ircommandsequence.dart';
import '../../potentiallibrary/graphs/seriesdata/graphdatapoint.dart';
import '../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';

class IrCommandSequenceToPlotSequenceConverter {
  // TODO This is to go
  GraphDataSeries convert(IrCommandSequence command) {
    List<GraphDataPoint> plots = List.empty(growable: true);

    var values = command.values;
    if (values.isNotEmpty) {
      plots.add(GraphDataPoint(
          values[0].time.toDouble(), values[0].value.toDouble()));
      var lastValue = values[0].value.toDouble();

      for (var i = 1; i < values.length; i++) {
        plots.add(GraphDataPoint(values[i].time.toDouble(), lastValue));
        plots.add(GraphDataPoint(
            values[i].time.toDouble(), values[i].value.toDouble()));
        lastValue = values[i].value.toDouble();
      }
    }

    return GraphDataSeries(plots);
  }
}
