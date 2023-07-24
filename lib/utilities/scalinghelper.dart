class ScalingHelper {
  final double horizontalExtent;
  final double verticalExtent;

  ScalingHelper({required this.horizontalExtent, required this.verticalExtent});

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
}
