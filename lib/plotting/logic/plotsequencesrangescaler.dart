import '../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import '../../potentiallibrary/graphs/scaling/graphseriesextent.dart';
import 'iplotsequencerangescaler.dart';
import 'iplotsequencesrangescaler.dart';

class PlotSequencesRangeScaler extends IPlotSequencesRangeScaler {
  IPlotSequenceRangeScaler _plotSequenceRangeScaler;

  PlotSequencesRangeScaler(this._plotSequenceRangeScaler);

  @override
  List<GraphDataSeries> scalePlotSequences(
      List<GraphDataSeries> plotSequences, GraphSeriesExtent range) {
    var scaled = plotSequences
        .map((e) => _plotSequenceRangeScaler.scalePlotSequence(e, range));
    return scaled.toList();
  }
}
