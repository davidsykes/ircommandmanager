import '../dataobjects/traces/tracepoints.dart';
import '../potentiallibrary/graphs/graphdataseries.dart';

class TracePointsToGraphDataSeriesConverter {
  GraphDataSeries convertTracePointsToGraphDataSeries(TracePoints tracePoints) {
    var points = tracePoints.points;
    var pointsToConvert = points.length;
    var currentPoint = 0;
    var plots = List<List<double>>.empty(growable: true);
    var lasty = points[currentPoint].value.toDouble();
    plots.add([points[currentPoint].time.toDouble(), lasty]);
    currentPoint++;

    while (currentPoint < pointsToConvert) {
      var x = points[currentPoint].time.toDouble();
      var y = points[currentPoint].value.toDouble();
      plots.add([x, lasty]);
      plots.add([x, y]);
      currentPoint++;
      lasty = y;
    }

    return GraphDataSeries(plots);
  }
}
