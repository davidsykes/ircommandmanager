import 'package:ircommandmanager/potentiallibrary/graphs/scaling/graphseriesextent.dart';

import 'seriesdata/graphdataseries.dart';

class GraphWindowData {
  final List<GraphDataSeries> seriesToDisplay = List.empty(growable: true);
  var graphSeriesExtent = GraphSeriesExtent(0, 0, 0, 0);
}
