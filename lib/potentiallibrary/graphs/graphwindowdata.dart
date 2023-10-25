import 'package:ircommandmanager/potentiallibrary/graphs/scaling/graphseriesextent.dart';
import 'scaling/graphseriesextentcalculator.dart';
import 'seriesdata/graphdataseries.dart';

class GraphWindowData {
  final _graphSeriesExtentCalculator = GraphSeriesExtentCalculator();
  final List<GraphDataSeries> dataSeries = List.empty(growable: true);
  var graphSeriesExtent = GraphSeriesExtent(0, 0, 0, 0);

  void addMultipleSeries(Iterable<GraphDataSeries> serieses) {
    for (final series in serieses) {
      dataSeries.add(series);
    }
    _recalculateGraphSeriesExtent();
  }

  void _recalculateGraphSeriesExtent() {
    graphSeriesExtent = _graphSeriesExtentCalculator.calculateRange(dataSeries);
  }
}
