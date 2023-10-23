import '../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import '../dataobjects/plotsequencesrange.dart';

abstract class IPlotSequencesRangeScaler {
  List<GraphDataSeries> scalePlotSequences(
      List<GraphDataSeries> plotSequences, PlotSequencesRange range);
}
