import '../dataobjects/traces/traceinfo.dart';
import '../dataobjects/traces/tracesdata.dart';
// TODO To be removed

abstract class ITraceDataController {
  Future<List<TraceInfo>> getSelectedTracesWithDetails();

  Future<TracesData> getTracesDataFuture();
  void refreshTraces();
  void deleteTraces(Iterable<String> tracesToDelete);
}
