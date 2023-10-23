import '../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import '../dataobjects/plotsequencesrange.dart';

abstract class IPlotSequencesRangeFinder {
  PlotSequencesRange calculateRange(List<GraphDataSeries> plotSequences);
}
