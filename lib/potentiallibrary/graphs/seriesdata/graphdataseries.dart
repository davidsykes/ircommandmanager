import 'graphdatapoint.dart';

class GraphDataSeries {
  final List<GraphDataPoint> plots;
  bool enable = true;

  GraphDataSeries(this.plots);

  Map<String, dynamic> toJson() =>
      {'plots': plots.map((p) => p.toJson()).toList()};
}
