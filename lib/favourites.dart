import 'package:flutter/material.dart';
import 'package:ircommandmanager/webaccess.dart';
import 'dataobjects/selectabletraceinfo.dart';

class ViewTracesPage extends StatefulWidget {
  const ViewTracesPage({super.key});

  @override
  State<ViewTracesPage> createState() => _ViewTracesPageFutureBuilder();
}

class _ViewTracesPageFutureBuilder extends State<ViewTracesPage> {
  final Future<List<SelectableTraceInfo>> _plots = getPlots();

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<List<SelectableTraceInfo>>(
        future: _plots,
        builder: (BuildContext context,
            AsyncSnapshot<List<SelectableTraceInfo>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = makeTraceViewPage(snapshot.data!);
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }

  List<Widget> makeTraceViewPage(List<SelectableTraceInfo> plots) {
    return <Widget>[
      ButtonBar(
        alignment: MainAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                deletePlots(plots);
              },
              child: Text('Delete')),
          ElevatedButton(onPressed: null, child: Text('Hello')),
        ],
      ),
      const Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 60,
      ),
      Expanded(
          child: ListView(
        children: <Widget>[for (var p in plots) makePlotListItem(p)],
      )),
    ];
  }

  Widget makePlotListItem(SelectableTraceInfo plot) {
    return ListTile(
      leading: Checkbox(
        value: plot.selected,
        onChanged: (bool? x) => setState(() {
          plot.toggle();
        }),
      ),
      title: Text(plot.traceInfo.name),
    );
  }

  static Future<List<SelectableTraceInfo>> getPlots() async {
    var plots = await WebAccess.getPlots();
    var selectables = List<SelectableTraceInfo>.empty(growable: true);
    for (var trace in plots) {
      selectables.add(SelectableTraceInfo(traceInfo: trace));
    }
    return selectables;
  }

  void deletePlots(List<SelectableTraceInfo> plots) {
    print(plots);
  }
}
