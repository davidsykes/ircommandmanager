import 'package:ircommandmanager/dataobjects/tracepoints.dart';
import '../dataobjects/plotpoint.dart';

class TraceToLinesConverter {
  List<PlotPoint> convertTraceToPlot(TracePoints tracePoints) {
    var points = tracePoints.points;
    var pointsToConvert = points.length;
    var currentPoint = 0;
    var plots = List<PlotPoint>.empty(growable: true);
    var lasty = points[currentPoint].value;
    plots.add(PlotPoint(x: points[currentPoint].time, y: lasty));
    currentPoint++;

    while (currentPoint < pointsToConvert) {
      var x = points[currentPoint].time;
      var y = points[currentPoint].value;
      plots.add(PlotPoint(x: x, y: lasty));
      plots.add(PlotPoint(x: x, y: y));
      currentPoint++;
      lasty = y;
    }

    return plots;
  }
}
