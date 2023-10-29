import 'package:flutter/material.dart';
import '../dataobjects/traces/traceinfo.dart';
import '../globalvariables.dart';
import '../potentiallibrary/tools/cacheddataloader.dart';
import '../utilities/converters/tracepointstographdataseriesconverter.dart';
import '../webservices/scopetraces/scopetraceaccess.dart';
import '../potentiallibrary/widgets/futurebuilder.dart';
import '../potentiallibrary/widgets/myselectablelist.dart';

class ViewTraceListPage extends StatefulWidget {
  final GlobalVariables globalVariables;
  const ViewTraceListPage(this.globalVariables, {super.key});

  @override
  State<ViewTraceListPage> createState() => _ViewTraceListPageFutureBuilder();
}

class _ViewTraceListPageFutureBuilder extends State<ViewTraceListPage> {
  CachedDataLoader<List<TraceInfo>>? cachedTracesLoader;
  late MySelectableList<TraceInfo> selectableListWidget;

  _ViewTraceListPageFutureBuilder() {
    selectableListWidget = MySelectableList(onSelect: onTraceSelected);
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
    var tracesToDelete =
        selectableListWidget.selectedItems.map((e) => e.fileName);
    ScopeTraceAccess().deleteTraces(tracesToDelete);
  }

  void selectAllTraces(List<TraceInfo> traces) {
    selectableListWidget.selectAll();
  }

  void refreshTraces() {
    cachedTracesLoader!.refresh();
  }

  void onTraceSelected(TraceInfo sItem) {
    setState(() {});
  }
}
