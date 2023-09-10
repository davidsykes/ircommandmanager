import 'package:ircommandmanager/plotting/dataobjects/plotsequence.dart';

import 'iplotsequencesrangefinder.dart';
import 'iplotsequencesrangescaler.dart';
import 'iplotsequencesunitsizescaler.dart';

class PlotSequencesUnitSizeScaler extends IPlotSequencesUnitSizeScaler {
  IPlotSequencesRangeFinder _plotSequencesRangeFinder;
  IPlotSequencesRangeScaler _plotSequencesRangeScaler;

  PlotSequencesUnitSizeScaler(
      this._plotSequencesRangeFinder, this._plotSequencesRangeScaler);

  @override
  List<PlotSequence> scaleToUnitSize(List<PlotSequence> plotSequences) {
    var range = _plotSequencesRangeFinder.calculateRange(plotSequences);
    var scaledSequences =
        _plotSequencesRangeScaler.scalePlotSequences(plotSequences, range);

    return scaledSequences;
  }
}
