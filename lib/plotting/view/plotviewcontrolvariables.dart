// TODO This is to go

class PlotViewControlVariables {
  //One instance, needs factory
  static PlotViewControlVariables? _instance;
  factory PlotViewControlVariables() =>
      _instance ??= PlotViewControlVariables._();
  PlotViewControlVariables._();

  int zoom = 1;
  int offset = 0;
  bool showTestPlot = false;
}
