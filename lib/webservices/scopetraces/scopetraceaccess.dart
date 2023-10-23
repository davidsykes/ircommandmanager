import 'package:ircommandmanager/webservices/webaccess.dart';
import '../../dataobjects/traces/traceinfo.dart';
import '../../dataobjects/traces/tracepoints.dart';
import '../../forremoval/itracedatacontroller.dart';
import '../../forremoval/tracedatacontoller.dart';

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
    print('Get trace details for $fileName');
    return td;
  }

  // TODO Everything below here is to go

  ITraceDataController? actualTraceDataController;

  ITraceDataController getTraceDataController() {
    actualTraceDataController ??= TraceDataController(webAccess: _webAccess);
    return actualTraceDataController!;
  }

  void deleteTraces(Iterable<String> tracesToDelete) {
    getTraceDataController().deleteTraces(tracesToDelete);
  }
}
