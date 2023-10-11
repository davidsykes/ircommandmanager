import 'package:flutter/material.dart';
import '../dataobjects/traces/traceinfo.dart';
import '../webservices/scopetraces/scopetraceaccess.dart';
import '../widgets/futurebuilder.dart';
import '../widgets/myselectablelist.dart';

class ViewTraceListPage2 extends StatefulWidget {
  const ViewTraceListPage2({super.key});

  @override
  State<ViewTraceListPage2> createState() => _ViewTraceListPage2FutureBuilder();
}

class _ViewTraceListPage2FutureBuilder extends State<ViewTraceListPage2> {
  late MySelectableList<TraceInfo> selectableList;

  _ViewTraceListPage2FutureBuilder() {
    selectableList = MySelectableList(select: onTraceSelected);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.displayMedium!,
        textAlign: TextAlign.center,
        child:
            createFutureBuilder<List<TraceInfo>>(getTraces, makeTraceViewPage));
  }

  Widget makeTraceViewPage(List<TraceInfo> traces) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: makeTraceViewPage2(traces),
      ),
    );
  }

  List<Widget> makeTraceViewPage2(List<TraceInfo> traces) {
    return <Widget>[
      OverflowBar(
        alignment: MainAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                setState(() {
                  refreshTraces();
                });
              },
              child: Text('Refresh')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  deleteTraces(traces);
                });
              },
              child: Text('Delete')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  selectAllTraces(traces);
                });
              },
              child: Text('Select All')),
        ],
      ),
      Expanded(
          child: ListView(
        children: selectableList.makeItemsList(),
      )),
    ];
  }

  Future<List<TraceInfo>> getTraces() async {
    try {
      var traces = await ScopeTraceAccess().getScopeTraces();
      refreshTraceList(traces);
      return traces;
    } catch (e) {
      return Future.error('Error getting traces: $e');
    }
  }

  void refreshTraceList(List<TraceInfo> traces) {
    selectableList.refresh(traces, (TraceInfo t) => t.name);
  }

  void deleteTraces(List<TraceInfo> traces) {
    // var tracesToDelete = traces
    //     .getAllTraces()
    //     .where((trace) => trace.isSelected())
    //     .map((trace) => trace.traceInfo.fileName);

    // ScopeTraceAccess().deleteTraces(tracesToDelete);
  }

  void selectAllTraces(List<TraceInfo> traces) {
    // for (var trace in traces.getAllTraces()) {
    //   if (!trace.isSelected()) {
    //     trace.toggle();
    //   }
    // }
  }

  void refreshTraces() {
    ScopeTraceAccess().getTraceDataController().refreshTraces();
  }

  void onTraceSelected(TraceInfo sItem) {
    setState(() {
      print(selectableList.selectedItems.length);
    });
  }
}
