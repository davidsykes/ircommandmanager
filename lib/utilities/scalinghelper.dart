class ScalingHelper {
  final double screenWidth;
  final double screenHeight;
  final int zoom;
  final int offset;

  ScalingHelper(
      {required this.screenWidth,
      required this.screenHeight,
      required this.zoom,
      required this.offset});

  double getMaximumXValue(List<List<List<double>>> values) {
    double maxx = 0;
    for (List<List<double>> plot in values) {
      for (List<double> p in plot) {
        if (p[0] > maxx) {
          maxx = p[0];
        }
      }
    }
    return maxx;
  }

  double getMaximumYValue(List<List<List<double>>> values) {
    double maxy = 0;
    for (List<List<double>> plot in values) {
      for (List<double> p in plot) {
        if (p[1] > maxy) {
          maxy = p[1];
        }
      }
    }
    return maxy;
  }

  List<List<double>> scaleToHorizontalExtent(
      {required List<List<double>> plot, required double maxY}) {
    var horizontalScale = screenWidth / maxY * zoom;

    var scaled = plot.map((p) => [p[0] * horizontalScale, p[1]]);

    return scaled.toList();
  }
}
