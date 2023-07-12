class TracePoint {
  late int time;
  late int value;

  TracePoint(rawPoint) {
    time = rawPoint['time'];
    value = rawPoint['value'];
  }
}
