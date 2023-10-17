import 'package:flutter/material.dart';
import 'plotting/view/plotviewcontrolvariables.dart';

class MyAppState extends ChangeNotifier {
  PlotViewControlVariables plotViewControlVariables =
      PlotViewControlVariables();
  bool showTestPlots = false;
}
