import 'graphdatapoint.dart';

class GraphDataSeries {
  final List<GraphDataPoint> plots;

  GraphDataSeries(this.plots);

  Map<String, dynamic> toJson() =>
      {'plots': plots.map((p) => p.toJson()).toList()};
}
