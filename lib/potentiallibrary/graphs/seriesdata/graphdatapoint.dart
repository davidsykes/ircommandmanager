class GraphDataPoint {
  double x = 0;
  double y = 0;

  GraphDataPoint(this.x, this.y);

  Map<String, dynamic> toJson() => {'x': x, 'y': y};
}
