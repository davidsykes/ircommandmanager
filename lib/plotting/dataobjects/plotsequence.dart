import 'plotvalue.dart';

class PlotSequence {
  List<PlotValue> plots = List.empty();

  PlotSequence(this.plots);

  Map<String, dynamic> toJson() =>
      {'plots': plots.map((p) => p.toJson()).toList()};
}
