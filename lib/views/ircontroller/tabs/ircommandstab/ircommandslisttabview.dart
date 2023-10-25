import 'package:flutter/material.dart';
import 'package:ircommandmanager/webservices/webaccess.dart';
import '../../../../dataobjects/ircommandsequence.dart';
import '../../../../potentiallibrary/widgets/myselectablelist.dart';
import '../../../../potentiallibrary/widgets/overflowbar.dart';
import '../../../../potentiallibrary/widgets/futurebuilder.dart';
import '../../ircommandsdata.dart';
import 'ircommandsplotwindow.dart';
import 'ircontrollercommandslistoverflowbar.dart';

class IrCommandsListTabView extends StatefulWidget {
  @override
  State<IrCommandsListTabView> createState() => _IrCommandsListTabViewState();
}

class _IrCommandsListTabViewState extends State<IrCommandsListTabView> {
  final _counter = ValueNotifier<int>(0);
  late IrCommandsPlotWindow _plotWindow;
  MySelectableList<IrCommandSequence>? _selectableList;
  bool _showCommandResults = false;

  _IrCommandsListTabViewState() {
    _plotWindow = IrCommandsPlotWindow(repaint: _counter);
  }

  MySelectableList<IrCommandSequence> makeMySelectableList() {
    return MySelectableList<IrCommandSequence>(select: itemSelected);
  }

  void itemSelected(IrCommandSequence sItem) {
    setState(() {
      _plotWindow.showCommand(sItem);
      _counter.value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return createFutureBuilder(loadIrCommandsDataAndMakeSelectables, makePage);
  }

  Future<IrCommandsData> loadIrCommandsDataAndMakeSelectables() async {
    var commands = await IrCommandsData().loadIrCommandsData();
    if (_selectableList == null) {
      _selectableList = makeMySelectableList();
      _selectableList!.refresh(
          commands.commandsList,
          (IrCommandSequence s) => s.name,
          (IrCommandSequence s) => "IrCommandSequence");
    }
    return commands;
  }

  Widget makePage(IrCommandsData irCommandsData) {
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
    if (_showCommandResults) {
      return Text('Show results');
    } else {
      return makeWidgetPlotWindowWithEdging();
    }
  }

  Widget makeWidgetIrControllerCommandsManager() {
    return Column(
      children: <Widget>[
        createOverflowBar(
            IrControllerCommandsListOverflowBar(sendButtonPressed)),
        Expanded(
          child: _selectableList!.makeListWidget(),
        ),
      ],
    );
  }

  void sendButtonPressed() async {
    var commandsToSend = _selectableList!.selectedItems;
    var webAccess = WebAccess('192.168.1.75');
    String results = '';

    for (var c in commandsToSend) {
      var result = await webAccess.getTextWebData('code/${c.name}');
      results = results + result;
    }

    setState(() {
      _showCommandResults = true;
    });
    print(results);
  }

  Widget makeWidgetPlotWindowWithEdging() {
    return Column(
      children: <Widget>[
        Text(''),
        Expanded(
          child: CustomPaint(
            size: Size.infinite,
            painter: _plotWindow.plotWindow,
          ),
        ),
        Text(''),
      ],
    );
  }
}
