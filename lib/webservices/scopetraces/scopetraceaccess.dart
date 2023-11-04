import 'package:ircommandmanager/dataobjects/traces/tracepoint.dart';
import 'package:ircommandmanager/webservices/webaccess.dart';
import '../../dataobjects/traces/traceinfo.dart';
import '../../dataobjects/traces/tracepoints.dart';

class ScopeTraceAccess {
  //One instance, needs factory
  late WebAccess _webAccess;

  static ScopeTraceAccess? _instance;
  factory ScopeTraceAccess() => _instance ??= ScopeTraceAccess._();
  ScopeTraceAccess._() {
    _webAccess = WebAccess('192.168.1.142:5000');
  }

  Future<List<TraceInfo>> getScopeTraces() async {
    final decoded = await _webAccess.getJsonWebData('tracenames');

    var traces = List<TraceInfo>.empty(growable: true);
    for (var trace in decoded) {
      traces.add(TraceInfo(
          name: trace['tracename'],
          fileName: trace['tracepath'],
          traceCount: trace['tracecount'],
          traceLength: trace['tracelength']));
    }

    return traces;
  }

  Future<List<TraceInfo>> getScopeTraceDetails(
      List<TraceInfo> selectedTraces) async {
    for (var trace in selectedTraces) {
      trace.traceDetails ??= await getTraceDetails(trace.fileName);
    }
    return selectedTraces;
  }

  Future<TracePoints> getTraceDetails(String fileName) async {
    final rawPoints = await _webAccess.getJsonWebData('trace/$fileName');

    TracePoints td = TracePoints.fromJsonPoints(rawPoints);
    td = convertTrace(td);
    return td;
  }

  Future<void> deleteTraces(Iterable<String> tracesToDelete) async {
    for (var trace in tracesToDelete) {
      await deleteTrace(trace);
    }
  }

  Future<void> deleteTrace(String trace) async {
    var result = await _webAccess.post('delete/$trace');
    print(result);
  }

  TracePoints convertTrace(TracePoints td) {
    return TracePoints(td.points
        .map((e) => TracePoint(time: e.time, value: convertValue(e.value))));
  }

  int convertValue(int value) {
    return value > 127 ? 0 : 1;
  }
}
