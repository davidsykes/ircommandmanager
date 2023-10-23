import '../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import '../../potentiallibrary/graphs/scaling/graphseriesextent.dart';

abstract class IPlotSequencesRangeScaler {
  List<GraphDataSeries> scalePlotSequences(
      List<GraphDataSeries> plotSequences, GraphSeriesExtent range);
}
