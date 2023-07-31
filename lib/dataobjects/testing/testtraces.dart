import '../traces/traceinfo.dart';
import '../traces/tracepoint.dart';
import '../traces/tracepoints.dart';
import '../traces/tracesdata.dart';

class TestTraces {
  late Future<TracesData> getTracesDataFuture;
  TestTraces() {
    getTracesDataFuture = getTracesData();
  }

  Future<TracesData> getTracesData() {
    List<TraceInfo> traces = List<TraceInfo>.empty(growable: true);

    var tenTrace = make10Trace();

    var trace =
        TraceInfo(name: '10', fileName: '10', traceCount: 10, traceLength: 10);
    trace.traceDetails = tenTrace;

    traces.add(trace);

    return Future(() => TracesData(traces));
  }

  TracePoints make10Trace() {
    var points = [
      TracePoint(time: 0, value: 0),
      TracePoint(time: 1, value: 1),
      TracePoint(time: 2, value: 2),
      TracePoint(time: 3, value: 3),
      TracePoint(time: 4, value: 4),
      TracePoint(time: 5, value: 5),
      TracePoint(time: 6, value: 6),
      TracePoint(time: 7, value: 7),
      TracePoint(time: 8, value: 8),
      TracePoint(time: 9, value: 9),
      TracePoint(time: 10, value: 10),
    ];
    return TracePoints(points);
  }
}
