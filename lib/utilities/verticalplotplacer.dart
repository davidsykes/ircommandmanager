const double border = 0.05;

class VerticalPlotPlacer {
  late int _screenHeight;
  late double upperScreenCoordinate;
  late double lowerScreenCoordinate;
  late double usableScreenHeight;

  VerticalPlotPlacer(int screenHeight, int plotCount) {
    _screenHeight = screenHeight;
    upperScreenCoordinate = _screenHeight * border;
    lowerScreenCoordinate = _screenHeight * (1 - border);
    usableScreenHeight = lowerScreenCoordinate - upperScreenCoordinate;
  }

  List<List<double>> placePlots(List<List<double>> values) {
    return values.map((v) => [v[0], reposition(v[1])]).toList();
  }

  double reposition(double v) {
    var p = lowerScreenCoordinate - v * usableScreenHeight;

    return p;
  }
}
