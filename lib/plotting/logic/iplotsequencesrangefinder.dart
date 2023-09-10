import 'package:ircommandmanager/plotting/dataobjects/plotsequence.dart';

import '../dataobjects/plotsequencesrange.dart';

abstract class IPlotSequencesRangeFinder {
  PlotSequencesRange calculateRange(List<PlotSequence> plotSequences);
}
