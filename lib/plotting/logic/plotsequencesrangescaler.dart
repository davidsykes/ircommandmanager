import '../dataobjects/plotsequence.dart';
import '../dataobjects/plotsequencesrange.dart';
import 'iplotsequencerangescaler.dart';
import 'iplotsequencesrangescaler.dart';

class PlotSequencesRangeScaler extends IPlotSequencesRangeScaler {
  IPlotSequenceRangeScaler _plotSequenceRangeScaler;

  PlotSequencesRangeScaler(this._plotSequenceRangeScaler);

  @override
  List<PlotSequence> scalePlotSequences(
      List<PlotSequence> plotSequences, PlotSequencesRange range) {
    var scaled = plotSequences
        .map((e) => _plotSequenceRangeScaler.scalePlotSequence(e, range));
    return scaled.toList();
  }
}
