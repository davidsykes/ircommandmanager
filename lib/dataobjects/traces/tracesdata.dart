import 'selectabletraceinfo.dart';
import 'traceinfo.dart';

// TODO This is redundant
class TracesData {
  late List<SelectableTraceInfo> _traces;

  TracesData(List<TraceInfo> traces) {
    _traces = traces.map((t) => SelectableTraceInfo(traceInfo: t)).toList();
  }

  List<SelectableTraceInfo> getAllTraces() {
    return _traces;
  }

  List<TraceInfo> getSelectedTraces() {
    return _traces
        .where((t) => t.isSelected())
        .map((t) => t.traceInfo)
        .toList();
  }
}
