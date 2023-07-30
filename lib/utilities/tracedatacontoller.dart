import 'package:ircommandmanager/webaccess.dart';
import '../dataobjects/traceinfo.dart';
import '../dataobjects/tracepoints.dart';
import '../dataobjects/tracesdata.dart';

class TraceDataController {
  late WebAccess webAccess;
  late Future<TracesData> getTracesDataFuture;

  TraceDataController({required this.webAccess}) {
    getTracesDataFuture = getTracesData();
  }

  Future<TracesData> getTracesData() async {
    final decoded = await webAccess.getWebData('tracenames');

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

  Future<List<TraceInfo>> getSelectedTracesWithDetails() async {
    var traces = await getTracesDataFuture;
    var selectedTraces = traces.getSelectedTraces();

    for (var trace in selectedTraces) {
      trace.traceDetails ??= await getTraceDetails(trace.fileName);
    }
    return selectedTraces.toList();
  }

  Future<TracePoints> getTraceDetails(String fileName) async {
    final rawPoints = await webAccess.getWebData('trace/$fileName');

    TracePoints td = TracePoints.fromJsonPoints(rawPoints);
    print('Get trace details for $fileName');
    return td;
  }
}
