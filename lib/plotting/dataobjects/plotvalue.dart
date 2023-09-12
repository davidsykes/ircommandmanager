class PlotValue {
  int x = 0;
  int y = 0;

  PlotValue(this.x, this.y);

  Map<String, dynamic> toJson() => {'x': x, 'y': y};
}
