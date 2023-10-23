import '../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import '../dataobjects/plotsequencesrange.dart';

abstract class IPlotSequenceRangeScaler {
  GraphDataSeries scalePlotSequence(
      GraphDataSeries plotSequence, PlotSequencesRange range);
}
