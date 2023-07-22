class TracePoint {
  late int time;
  late int value;

  TracePoint({required this.time, required this.value});

  static TracePoint fromJsonPoint(jsonPoint) {
    return TracePoint(time: jsonPoint['time'], value: jsonPoint['value']);
  }
}
