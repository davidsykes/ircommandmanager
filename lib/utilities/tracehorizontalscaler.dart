class TraceHorizontalScaler {
  final double screenWidth;
  final int zoom;
  final int offset;

  TraceHorizontalScaler(
      {required this.screenWidth, required this.zoom, required this.offset});

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

  List<List<double>> scaleToHorizontalExtent(
      {required List<List<double>> plot, required double maxX}) {
    if (maxX > 0) {
      var horizontalScale = screenWidth / maxX * zoom;
      var horizontalOffset = offset * screenWidth * zoom / 100;

      var scaled =
          plot.map((p) => [p[0] * horizontalScale - horizontalOffset, p[1]]);

      return scaled.toList();
    }
    return plot;
  }

  List<List<double>> scalePlotValuesToUnitRange(List<List<double>> scaled) {
    var values = scaled.map((v) => v[1]);
    var min = values.reduce((curr, next) => curr < next ? curr : next);
    var max = values.reduce((curr, next) => curr > next ? curr : next);
    var range = max - min;

    var newValues = scaled.map((v) => [v[0], (v[1] - min) / range]).toList();

    return newValues;
  }
}
