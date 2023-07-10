import 'package:flutter/material.dart';
import 'dataobjects/selectabletraceinfo.dart';
import 'dataobjects/traceinfo.dart';
import 'webaccess.dart';

class MyAppState extends ChangeNotifier {
  late WebAccess webAccess;
  late Future<List<TraceInfo>> getTraceListFuture;

  MyAppState() {
    webAccess = WebAccess('192.168.1.142:5000');
    getTraceListFuture = webAccess.getTraces();
  }

  List<SelectableTraceInfo> selectableTraces =
      List<SelectableTraceInfo>.empty();

  Future<List<SelectableTraceInfo>> getSelectableTraceList() async {
    if (selectableTraces.isEmpty) {
      var tracedata = await getTraceListFuture;
      selectableTraces = tracedata
          .map((traceInfo) => SelectableTraceInfo(traceInfo: traceInfo))
          .toList();
    }
    return selectableTraces;
  }

  List<SelectableTraceInfo> getCachedSelectableTraceList() {
    return selectableTraces;
  }

  List<TraceInfo> getSelectedTraces() {
    var selectedTraces = getCachedSelectableTraceList()
        .where((trace) => trace.selected)
        .map((selectableTraceInfo) => selectableTraceInfo.traceInfo);
    return selectedTraces.toList();
  }

  Future<List<TraceInfo>> getSelectedTracesWithDetails() async {
    var selectedTraces = getSelectedTraces();
    for (var trace in selectedTraces) {
      trace.traceDetails ??= await webAccess.getTraceDetails(trace.fileName);
    }
    return selectedTraces.toList();
  }

  void deleteTraces(Iterable<String> tracesToDelete) {
    webAccess.deleteTraces(tracesToDelete);
  }
}
