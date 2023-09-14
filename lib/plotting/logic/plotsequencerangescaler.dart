import 'package:ircommandmanager/plotting/dataobjects/plotvalue.dart';

import '../dataobjects/plotsequence.dart';
import '../dataobjects/plotsequencesrange.dart';
import 'iplotsequencerangescaler.dart';

class PlotSequenceRangeScaler extends IPlotSequenceRangeScaler {
  @override
  PlotSequence scalePlotSequence(
      PlotSequence plotSequence, PlotSequencesRange range) {
    return PlotSequence(
        plotSequence.plots.map((e) => _scalePlotValue(e, range)).toList());
  }

  PlotValue _scalePlotValue(PlotValue v, PlotSequencesRange range) {
    return PlotValue(_scaleValue(v.x, range.minx, range.maxx),
        _scaleValue(v.y, range.miny, range.maxy));
  }

  double _scaleValue(double v, double min, double max) {
    return ((v - min) / (max - min));
  }
}
