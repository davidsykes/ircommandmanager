import '../../potentiallibrary/graphs/seriesdata/graphdatapoint.dart';
import '../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import '../dataobjects/plotsequencesrange.dart';
import 'iplotsequencerangescaler.dart';

class PlotSequenceRangeScaler extends IPlotSequenceRangeScaler {
  @override
  GraphDataSeries scalePlotSequence(
      GraphDataSeries plotSequence, PlotSequencesRange range) {
    return GraphDataSeries(
        plotSequence.plots.map((e) => _scalePlotValue(e, range)).toList());
  }

  GraphDataPoint _scalePlotValue(GraphDataPoint v, PlotSequencesRange range) {
    return GraphDataPoint(_scaleValue(v.x, range.minx, range.maxx),
        _scaleValue(v.y, range.miny, range.maxy));
  }

  double _scaleValue(double v, double min, double max) {
    return ((v - min) / (max - min));
  }
}
