import 'traces/tracepoint.dart';

class IrCommandSequence {
  final String name;
  late List<TracePoint> values;

  IrCommandSequence(this.name) {
    values = List.empty(growable: false);
  }
}
