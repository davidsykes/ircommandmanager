import '../dataobjects/plotsequence.dart';
import '../dataobjects/plotsequencesrange.dart';

abstract class IPlotSequencesRangeScaler {
  List<PlotSequence> scalePlotSequences(
      List<PlotSequence> plotSequences, PlotSequencesRange range);
}
