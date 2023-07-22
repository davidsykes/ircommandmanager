class TracePoint {
  late int time;
  late int value;

  TracePoint(int time, int value) {
    time = time;
    value = value;
  }

  static TracePoint fromJsonPoint(jsonPoint) {
    return TracePoint(jsonPoint['time'], jsonPoint['value']);
  }
}
