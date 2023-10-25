import 'package:flutter/material.dart';
import '../dataobjects/traces/traceinfo.dart';
import '../globalvariables.dart';
import '../potentiallibrary/tools/cacheddataloader.dart';
import '../utilities/tracepointstographdataseriesconverter.dart';
import '../webservices/scopetraces/scopetraceaccess.dart';
import '../potentiallibrary/widgets/futurebuilder.dart';
import '../potentiallibrary/widgets/myselectablelist.dart';

class ViewTraceListPage2 extends StatefulWidget {
  final GlobalVariables globalVariables;
  const ViewTraceListPage2(this.globalVariables, {super.key});

  @override
  State<ViewTraceListPage2> createState() => _ViewTraceListPage2FutureBuilder();
}

class _ViewTraceListPage2FutureBuilder extends State<ViewTraceListPage2> {
  CachedDataLoader<List<TraceInfo>>? cachedTracesLoader;
  late MySelectableList<TraceInfo> selectableListWidget;

  _ViewTraceListPage2FutureBuilder() {
    selectableListWidget = MySelectableList(select: onTraceSelected);
  }

  @override
  void initState() {
    super.initState();
    cachedTracesLoader = CachedDataLoader<List<TraceInfo>>(
        widget.globalVariables.cachedTraces,
        loadTraces,
        refreshTraceListWidget);
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
                  addTracesToPlots();
                });
              },
              child: Text('Add to plots')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  refreshTraces();
                });
              },
              child: Text('RefreshUT')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  deleteTraces(traces);
                });
              },
              child: Text('DeleteUT')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  selectAllTraces(traces);
                });
              },
              child: Text('Select AllUT')),
        ],
      ),
      Expanded(
        child: selectableListWidget.makeListWidget(),
      ),
    ];
  }

  Future<List<TraceInfo>> getTraces() async {
    return await cachedTracesLoader!.getData();
  }

  Future<List<TraceInfo>> loadTraces() async {
    try {
      var traces = await ScopeTraceAccess().getScopeTraces();
      refreshTraceListWidget(traces);
      return traces;
    } catch (e) {
      return Future.error('Error getting traces: $e');
    }
  }

  void refreshTraceListWidget(List<TraceInfo> traces) {
    selectableListWidget.refresh(traces, (TraceInfo t) => t.name,
        (TraceInfo t) => '${t.traceCount} traces. ${t.traceLength}uS');
  }

  Future<void> addTracesToPlots() async {
    var selectedTraces = selectableListWidget.selectedItems;
    selectedTraces =
        await ScopeTraceAccess().getScopeTraceDetails(selectedTraces);
    var converter = TracePointsToGraphDataSeriesConverter();
    var dataSeries = selectedTraces.map(
        (e) => converter.convertTracePointsToGraphDataSeries(e.traceDetails!));
    widget.globalVariables.graphWindowWidget.addDataSeries(dataSeries);
  }

  void deleteTraces(List<TraceInfo> traces) {
    // TODO: implement deleteTraces
    // var tracesToDelete = traces
    //     .getAllTraces()
    //     .where((trace) => trace.isSelected())
    //     .map((trace) => trace.traceInfo.fileName);

    // ScopeTraceAccess().deleteTraces(tracesToDelete);
  }

  void selectAllTraces(List<TraceInfo> traces) {
    // TODO: implement selectAllTraces
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
    setState(() {});
  }
}
