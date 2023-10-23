import '../../potentiallibrary/graphs/seriesdata/graphdatapoint.dart';

class PlotViewport {
  double left = 0;
  double top = 1;
  double right = 1;
  double bottom = 0;

  List<GraphDataPoint> scaleToViewport(
      List<GraphDataPoint> plots, double width, double height) {
    return plots.map((p) => _scaleToViewPort(p, width, height)).toList();
  }

  GraphDataPoint _scaleToViewPort(
      GraphDataPoint p, double width, double height) {
    var x = p.x * width;
    var y = p.y * height;
    return GraphDataPoint(x, y);
  }
}
