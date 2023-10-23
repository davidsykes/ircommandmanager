import '../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';

abstract class IPlotSequencesUnitSizeScaler {
  List<GraphDataSeries> scaleToUnitSize(List<GraphDataSeries> plotSequences);
}
