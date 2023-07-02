import 'traceinfo.dart';

class SelectableTraceInfo {
  final TraceInfo traceInfo;
  bool selected = false;

  SelectableTraceInfo({required this.traceInfo});

  toggle() {
    selected = !selected;
  }
}
