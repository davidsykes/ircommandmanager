class PlotValue {
  double x = 0;
  double y = 0;

  PlotValue(this.x, this.y);

  Map<String, dynamic> toJson() => {'x': x, 'y': y};
}
