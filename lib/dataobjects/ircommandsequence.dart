import 'traces/tracepoints.dart';

class IrCommandSequence extends TracePoints {
  final String name;

  IrCommandSequence(this.name) : super(List.empty(growable: false));
}
