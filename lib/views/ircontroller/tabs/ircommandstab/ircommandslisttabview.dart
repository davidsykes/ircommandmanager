import 'package:flutter/material.dart';
import 'package:ircommandmanager/webservices/webaccess.dart';
import '../../../../dataobjects/ircommandsequence.dart';
import '../../../../globalvariables.dart';
import '../../../../potentiallibrary/tools/cacheddataloader2.dart';
import '../../../../potentiallibrary/widgets/myselectablelist.dart';
import '../../../../potentiallibrary/widgets/overflowbar.dart';
import '../../../../potentiallibrary/widgets/futurebuilder.dart';
import '../../../../utilities/converters/tracepointstographdataseriesconverter.dart';
import '../../ircommandsdata.dart';
import 'ircontrollercommandslistoverflowbar.dart';

class IrCommandsListTabView extends StatefulWidget {
  final GlobalVariables globalVariables;
  const IrCommandsListTabView(this.globalVariables, {super.key});

  @override
  State<IrCommandsListTabView> createState() => _IrCommandsListTabViewState();
}

class _IrCommandsListTabViewState extends State<IrCommandsListTabView> {
  final _counter = ValueNotifier<int>(0);
  late MySelectableList<IrCommandSequence> _selectableList;
  late CachedDataLoader2<List<IrCommandSequence>> _irCommandSequences;

  _IrCommandsListTabViewState() {
    _selectableList =
        MySelectableList<IrCommandSequence>(onSelect: itemSelected);
    _irCommandSequences = CachedDataLoader2<List<IrCommandSequence>>(
        loadIrCommandSequences, onIrCommandSequencesLoaded);
  }

  Future<List<IrCommandSequence>> loadIrCommandSequences() {
    return IrCommandsData().loadIrCommandSequences();
  }

  void onIrCommandSequencesLoaded(List<IrCommandSequence> data) {
    _selectableList.refresh(data, (IrCommandSequence s) => s.name,
        (IrCommandSequence s) => "IrCommandSequence");
  }

  void itemSelected(IrCommandSequence sItem) {
    setState(() {
      _counter.value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return createFutureBuilder(loadIrCommandsDataAndMakeSelectables, makePage);
  }

  Future<List<IrCommandSequence>> loadIrCommandsDataAndMakeSelectables() async {
    var commands = await _irCommandSequences.getData();
    return commands;
  }

  Widget makePage(List<IrCommandSequence> commands) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 25,
          child: makeWidgetIrControllerCommandsManager(),
        ),
        Expanded(
          flex: 75,
          child: chooseBetweenPlotWindowAndCommandResult(),
        ),
      ],
    );
  }

  Widget chooseBetweenPlotWindowAndCommandResult() {
    return Text('Show results');
  }

  Widget makeWidgetIrControllerCommandsManager() {
    return Column(
      children: <Widget>[
        createOverflowBar(IrControllerCommandsListOverflowBar(
            sendButtonPressed, plotButtonPressed)),
        Expanded(
          child: _selectableList.makeListWidget(),
        ),
      ],
    );
  }

  void sendButtonPressed() async {
    var commandsToSend = _selectableList.selectedItems;
    var webAccess = WebAccess('192.168.1.75');
    String results = '';

    for (var c in commandsToSend) {
      var result = await webAccess.getTextWebData('code/${c.name}');
      results = results + result;
    }

    setState(() {});
    print(results);
  }

  void plotButtonPressed() {
    var commandsToPlot = _selectableList.selectedItems;
    var converter = TracePointsToGraphDataSeriesConverter();
    var dataSeries = commandsToPlot
        .map((e) => converter.convertTracePointsToGraphDataSeries(e));
    widget.globalVariables.graphWindowWidget.addDataSeries(dataSeries);
  }
}
