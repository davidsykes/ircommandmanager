import 'codeconversion/codetobeconverted.dart';
import 'dataobjects/traces/traceinfo.dart';
import 'potentiallibrary/graphs/graphwindowwidget.dart';
import 'potentiallibrary/tools/cacheddata.dart';

class GlobalVariables {
  var graphWindowWidget = GraphWindowWidget();
  var cachedTraces = CachedData<List<TraceInfo>>();
  var codeToBeConverted = CodeToBeConverted();
}
