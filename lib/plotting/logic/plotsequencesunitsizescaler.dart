import '../../potentiallibrary/graphs/scaling/graphseriesextentcalculator.dart';
import '../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';
import 'iplotsequencesrangescaler.dart';
import 'iplotsequencesunitsizescaler.dart';

class PlotSequencesUnitSizeScaler extends IPlotSequencesUnitSizeScaler {
  IGraphSeriesExtentCalculator _plotSequencesRangeFinder;
  IPlotSequencesRangeScaler _plotSequencesRangeScaler;

  PlotSequencesUnitSizeScaler(
      this._plotSequencesRangeFinder, this._plotSequencesRangeScaler);

  @override
  List<GraphDataSeries> scaleToUnitSize(List<GraphDataSeries> plotSequences) {
    var range = _plotSequencesRangeFinder.calculateRange(plotSequences);
    var scaledSequences =
        _plotSequencesRangeScaler.scalePlotSequences(plotSequences, range);

    return scaledSequences;
  }
}
