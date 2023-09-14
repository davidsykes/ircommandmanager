import 'package:ircommandmanager/plotting/dataobjects/plotvalue.dart';

class PlotViewport {
  double left = 0;
  double top = 1;
  double right = 1;
  double bottom = 0;

  List<PlotValue> scaleToViewport(
      List<PlotValue> plots, double width, double height) {
    return plots.map((p) => _scaleToViewPort(p, width, height)).toList();
  }

  PlotValue _scaleToViewPort(PlotValue p, double width, double height) {
    var x = p.x * width;
    var y = p.y * height;
    return PlotValue(x, y);
  }
}
