import 'package:ircommandmanager/plotting/dataobjects/plotsequence.dart';

abstract class IPlotSequencesUnitSizeScaler {
  List<PlotSequence> scaleToUnitSize(List<PlotSequence> plotSequences);
}
