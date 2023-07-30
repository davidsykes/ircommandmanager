import 'package:flutter/material.dart';
import 'dataobjects/plotviewcontrolvariables.dart';
import 'dataobjects/tracesdata.dart';
import 'utilities/tracedatacontoller.dart';
import 'webaccess.dart';

class MyAppState extends ChangeNotifier {
  late WebAccess webAccess;
  late TraceDataController traceDataController;
  PlotViewControlVariables plotViewControlVariables =
      PlotViewControlVariables();

  MyAppState() {
    webAccess = WebAccess('192.168.1.142:5000');
    traceDataController = TraceDataController(webAccess: webAccess);
  }

  Future<TracesData> getTracesDataFuture() async {
    return traceDataController.getTracesDataFuture;
  }

  void deleteTraces(Iterable<String> tracesToDelete) {
    webAccess.deleteTraces(tracesToDelete);
  }
}
