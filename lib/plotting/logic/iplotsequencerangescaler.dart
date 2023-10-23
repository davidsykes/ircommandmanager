import '../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import '../../potentiallibrary/graphs/scaling/graphseriesextent.dart';

abstract class IPlotSequenceRangeScaler {
  GraphDataSeries scalePlotSequence(
      GraphDataSeries plotSequence, GraphSeriesExtent range);
}
