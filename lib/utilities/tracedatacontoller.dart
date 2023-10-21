import 'package:ircommandmanager/webservices/webaccess.dart';
import '../dataobjects/traces/traceinfo.dart';
import '../dataobjects/traces/tracepoints.dart';
import '../dataobjects/traces/tracesdata.dart';
import '../webservices/scopetraces/scopetraceaccess.dart';
import 'itracedatacontroller.dart';

class TraceDataController implements ITraceDataController {
  // TODO To be removed
  late WebAccess webAccess;
  late Future<TracesData> _getTracesDataFuture;

  TraceDataController({required this.webAccess}) {
    refreshTraces();
  }

  @override
  void refreshTraces() {
    _getTracesDataFuture = getTracesData();
  }

  @override
  Future<TracesData> getTracesDataFuture() {
    return _getTracesDataFuture;
  }

  Future<TracesData> getTracesData() async {
    List<TraceInfo> traces = await ScopeTraceAccess().getScopeTraces();

    return TracesData(traces);
  }

  @override
  Future<List<TraceInfo>> getSelectedTracesWithDetails() async {
    var traces = await getTracesDataFuture();
    var selectedTraces = traces.getSelectedTraces();

    for (var trace in selectedTraces) {
      trace.traceDetails ??= await getTraceDetails(trace.fileName);
    }
    return selectedTraces.toList();
  }

  Future<TracePoints> getTraceDetails(String fileName) async {
    final rawPoints = await webAccess.getJsonWebData('trace/$fileName');

    TracePoints td = TracePoints.fromJsonPoints(rawPoints);
    print('Get trace details for $fileName');
    return td;
  }

  @override
  void deleteTraces(Iterable<String> tracesToDelete) {
    for (var trace in tracesToDelete) {
      deleteTrace(trace);
    }
    refreshTraces();
  }

  void deleteTrace(String trace) async {
    var result = await webAccess.post('delete/$trace');

    print(result);
  }
}
