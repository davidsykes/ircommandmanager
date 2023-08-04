const int borderPercentage = 5;

class TraceVerticalScaler {
  final double screenHeight;
  final int traceCount;
  late int screenBottom;
  late int usableScreenHeight;

  TraceVerticalScaler({required this.screenHeight, required this.traceCount}) {
    screenBottom = screenHeight * borderPercentage ~/ 100;
    usableScreenHeight = screenHeight * (100 - borderPercentage * 2) ~/ 100;
  }

  List<List<double>> scalePlot(int plot, List<List<double>> values) {
    return values.map((v) => [v[0], reposition(v[1])]).toList();
  }

  double reposition(double v) {
    var p = screenBottom + v * usableScreenHeight;

    return p;
  }
}
