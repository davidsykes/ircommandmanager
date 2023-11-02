import '../../dataobjects/traces/tracepoints.dart';
import '../../potentiallibrary/graphs/seriesdata/graphdatapoint.dart';
import '../../potentiallibrary/graphs/seriesdata/graphdataseries.dart';

class TracePointsToGraphDataSeriesConverter {
  GraphDataSeries convertTracePointsToGraphDataSeries(TracePoints tracePoints) {
    var points = tracePoints.points;
    var pointsToConvert = points.length;
    var plots = List<GraphDataPoint>.empty(growable: true);

    if (pointsToConvert > 0) {
      var lasty = translateValue(points[0].value);
      plots.add(GraphDataPoint(points[0].time.toDouble(), lasty));
      var currentPoint = 0;

      while (currentPoint < pointsToConvert) {
        var x = points[currentPoint].time.toDouble();
        var y = translateValue(points[currentPoint].value);
        plots.add(GraphDataPoint(x, lasty));
        plots.add(GraphDataPoint(x, y));
        currentPoint++;
        lasty = y;
      }
    }

    return GraphDataSeries(plots);
  }

  double translateValue(int value) {
    return value > 127 ? 0 : 1;
  }
}
