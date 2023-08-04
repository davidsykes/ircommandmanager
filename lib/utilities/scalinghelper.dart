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
      {required List<List<double>> plot, required double maxX}) {
    var horizontalScale = screenWidth / maxX * zoom;
    var horizontalOffset = offset * screenWidth * zoom / 100;

    var scaled =
        plot.map((p) => [p[0] * horizontalScale - horizontalOffset, p[1]]);

    return scaled.toList();
  }

  List<List<double>> scalePlotToUnitRange(List<List<double>> scaled) {
    var values = scaled.map((v) => v[1]);
    var min = values.reduce((curr, next) => curr < next ? curr : next);
    var max = values.reduce((curr, next) => curr > next ? curr : next);
    var range = max - min;

    var newValues = scaled.map((v) => [v[0], (v[1] - min) / range]).toList();

    return newValues;
  }
}
