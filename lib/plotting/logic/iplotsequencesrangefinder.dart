import 'package:ircommandmanager/plotting/dataobjects/plotsequence.dart';

abstract class IPlotSequencesRangeFinder {
  void calculateRange(List<PlotSequence> plotSequences);
}
