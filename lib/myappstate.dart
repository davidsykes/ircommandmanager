import 'package:flutter/material.dart';
import 'plotting/view/plotviewcontrolvariables.dart';
import 'utilities/itracedatacontroller.dart';
import 'webservices/webaccess.dart';

class MyAppState extends ChangeNotifier {
  late WebAccess webAccess;
  ITraceDataController? actualTraceDataController;
  ITraceDataController? testTraceDataController;
  PlotViewControlVariables plotViewControlVariables =
      PlotViewControlVariables();
  bool showTestPlots = false;

  MyAppState() {
    webAccess = WebAccess('192.168.1.142:5000');
  }

  // ITraceDataController getTraceDataController2() {
  //   if (showTestPlots) {
  //     testTraceDataController ??= TestTraceDataController();
  //     return testTraceDataController!;
  //   }

  //   actualTraceDataController ??= TraceDataController(webAccess: webAccess);
  //   return actualTraceDataController!;
  // }

  // void deleteTraces(Iterable<String> tracesToDelete) {
  //   getTraceDataController2().deleteTraces(tracesToDelete);
  // }
}
