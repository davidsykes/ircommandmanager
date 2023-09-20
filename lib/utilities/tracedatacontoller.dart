import 'package:ircommandmanager/webaccess.dart';
import '../dataobjects/traces/traceinfo.dart';
import '../dataobjects/traces/tracepoints.dart';
import '../dataobjects/traces/tracesdata.dart';
import 'itracedatacontroller.dart';

class TraceDataController implements ITraceDataController {
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
    final decoded = await webAccess.getJsonWebData('tracenames');

    var traces = List<TraceInfo>.empty(growable: true);
    for (var trace in decoded) {
      traces.add(TraceInfo(
          name: trace['tracename'],
          fileName: trace['tracepath'],
          traceCount: trace['tracecount'],
          traceLength: trace['tracelength']));
    }

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
    //webAccess.deleteTraces(tracesToDelete);
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
