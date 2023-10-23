import '../dataobjects/traces/tracepoints.dart';
import '../potentiallibrary/graphs/seriesdata/graphdatapoint.dart';
import '../potentiallibrary/graphs/seriesdata/graphdataseries.dart';

class TracePointsToGraphDataSeriesConverter {
  GraphDataSeries convertTracePointsToGraphDataSeries(TracePoints tracePoints) {
    var points = tracePoints.points;
    var pointsToConvert = points.length;
    var currentPoint = 0;
    var plots = List<GraphDataPoint>.empty(growable: true);
    var lasty = points[currentPoint].value.toDouble();
    plots.add(GraphDataPoint(points[currentPoint].time.toDouble(), lasty));
    currentPoint++;

    while (currentPoint < pointsToConvert) {
      var x = points[currentPoint].time.toDouble();
      var y = points[currentPoint].value.toDouble();
      plots.add(GraphDataPoint(x, lasty));
      plots.add(GraphDataPoint(x, y));
      currentPoint++;
      lasty = y;
    }

    return GraphDataSeries(plots);
  }
}
