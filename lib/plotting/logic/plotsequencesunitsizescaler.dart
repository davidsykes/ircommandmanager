import 'package:ircommandmanager/plotting/dataobjects/plotsequence.dart';

import 'iplotsequencesrangefinder.dart';
import 'iplotsequencesunitsizescaler.dart';

class PlotSequencesUnitSizeScaler extends IPlotSequencesUnitSizeScaler {
  IPlotSequencesRangeFinder _plotSequencesRangeFinder;

  PlotSequencesUnitSizeScaler(this._plotSequencesRangeFinder);

  @override
  List<PlotSequence> scaleToUnitSize(List<PlotSequence> plotSequences) {
    _plotSequencesRangeFinder.calculateRange(plotSequences);

    return List.empty();
  }
}
