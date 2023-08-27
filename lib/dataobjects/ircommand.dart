import 'traces/tracepoint.dart';

class IrCommand {
  final String name;
  late List<TracePoint> points;

  IrCommand(this.name) {
    points = List.empty(growable: true);
  }
}
