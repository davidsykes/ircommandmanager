import 'dataobjects/traces/traceinfo.dart';
import 'potentiallibrary/graphs/graphwindowmanager.dart';
import 'potentiallibrary/tools/cacheddata.dart';

class GlobalVariables {
  var graphWindowManager = GraphWindowManager();
  var cachedTraces = CachedDataX<List<TraceInfo>>();
}
