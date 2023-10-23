import '../potentiallibrary/graphs/seriesdata/graphdatapoint.dart';

List<List<double>> graphDataSeriesToDoubles(List<GraphDataPoint> points) {
  return points.map((e) => [e.x, e.y]).toList();
}
