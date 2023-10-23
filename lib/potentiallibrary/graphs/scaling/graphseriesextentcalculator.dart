import 'dart:math';

import '../seriesdata/graphdataseries.dart';
import 'graphseriesextent.dart';

abstract class IGraphSeriesExtentCalculator {
  GraphSeriesExtent calculateRange(List<GraphDataSeries> plotSequences);
}

class GraphSeriesExtentCalculator extends IGraphSeriesExtentCalculator {
  @override
  GraphSeriesExtent calculateRange(List<GraphDataSeries> plotSequences) {
    var validSequences =
        plotSequences.where((s) => s.plots.isNotEmpty).toList();

    if (validSequences.isEmpty) {
      return GraphSeriesExtent(0, 0, 0, 0);
    }

    var range = _calculateRange(validSequences[0]);

    for (var i = 1; i < validSequences.length; i++) {
      var rangeToAdd = _calculateRange(validSequences[i]);
      range = addRanges(range, rangeToAdd);
    }
    return range;
  }

  GraphSeriesExtent _calculateRange(GraphDataSeries sequence) {
    var plots = sequence.plots;
    var range =
        GraphSeriesExtent(plots[0].x, plots[0].x, plots[0].y, plots[0].y);

    for (var plot in plots) {
      if (plot.x < range.minx) {
        range.minx = plot.x;
      } else if (plot.x > range.maxx) {
        range.maxx = plot.x;
      }
      if (plot.y < range.miny) {
        range.miny = plot.y;
      } else if (plot.y > range.maxy) {
        range.maxy = plot.y;
      }
    }
    return range;
  }

  GraphSeriesExtent addRanges(
      GraphSeriesExtent range, GraphSeriesExtent rangeToAdd) {
    return GraphSeriesExtent(
        min(range.minx, rangeToAdd.minx),
        max(range.maxx, rangeToAdd.maxx),
        min(range.miny, rangeToAdd.miny),
        max(range.maxy, rangeToAdd.maxy));
  }
}
