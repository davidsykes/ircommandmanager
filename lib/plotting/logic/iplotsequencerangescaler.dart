import '../dataobjects/plotsequence.dart';
import '../dataobjects/plotsequencesrange.dart';

abstract class IPlotSequenceRangeScaler {
  PlotSequence scalePlotSequence(
      PlotSequence plotSequence, PlotSequencesRange range);
}
