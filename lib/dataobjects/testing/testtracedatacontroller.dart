import '../../utilities/itracedatacontroller.dart';
import '../traces/traceinfo.dart';
import '../traces/tracepoint.dart';
import '../traces/tracepoints.dart';
import '../traces/tracesdata.dart';

class TestTraceDataController implements ITraceDataController {
  late Future<TracesData> _getTracesDataFuture;
  late TracesData traces;

  TestTraceDataController() {
    _getTracesDataFuture = getTracesData();
  }

  @override
  Future<TracesData> getTracesDataFuture() {
    return _getTracesDataFuture;
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

  @override
  void deleteTraces(Iterable<String> tracesToDelete) {}

  @override
  Future<List<TraceInfo>> getSelectedTracesWithDetails() async {
    var traces = await getTracesDataFuture();
    var selectedTraces = traces.getSelectedTraces();
    return selectedTraces;
  }

  TracePoints make10Trace() {
    var points = [
      TracePoint(time: 0, value: 0),
      TracePoint(time: 1, value: 50),
      TracePoint(time: 2, value: 100),
      TracePoint(time: 3, value: 150),
      TracePoint(time: 4, value: 200),
      TracePoint(time: 5, value: 250),
      TracePoint(time: 6, value: 300),
      TracePoint(time: 7, value: 350),
      TracePoint(time: 8, value: 400),
      TracePoint(time: 9, value: 450),
      TracePoint(time: 10, value: 500),
    ];
    return TracePoints(points);
  }
}
