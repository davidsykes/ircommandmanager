class ScalingHelper {
  final double screenWidth;
  final double screenHeight;

  ScalingHelper({required this.screenWidth, required this.screenHeight});

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
    var horizontalScale = screenWidth / maxY;

    var scaled = plot.map((p) => [p[0] * horizontalScale, p[1]]);

    return scaled.toList();
  }
}
