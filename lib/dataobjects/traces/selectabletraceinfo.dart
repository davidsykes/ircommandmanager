import 'traceinfo.dart';

// TODO This is redundant
class SelectableTraceInfo {
  final TraceInfo traceInfo;
  bool _selected = false;

  SelectableTraceInfo({required this.traceInfo});

  toggle() {
    _selected = !_selected;
  }

  isSelected() {
    return _selected;
  }
}
