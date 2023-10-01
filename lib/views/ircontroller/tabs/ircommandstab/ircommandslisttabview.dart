import 'package:flutter/material.dart';
import '../../../../dataobjects/ircommandsequence.dart';
import '../../../../plotting/view/plotwindow.dart';
import '../../../../widgets/myselectablelist.dart';
import '../../../../widgets/overflowbar.dart';
import '../../../../widgets/futurebuilder.dart';
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
  late MySelectableList _selectableList;

  _IrCommandsListTabViewState() {
    _plotWindow = IrCommandsPlotWindow(repaint: _counter);
    _selectableList = makeMySelectableList();
  }

  MySelectableList makeMySelectableList() {
    return MySelectableList(select: itemSelected);
  }

  void itemSelected(ISelectableItem sItem) {
    setState(() {
      _plotWindow.showCommand(sItem.item as IrCommandSequence);
      _counter.value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return createFutureBuilder(loadIrCommandsDataAndMakeSelectables, makePage);
  }

  Future<IrCommandsData> loadIrCommandsDataAndMakeSelectables() async {
    var commands = await IrCommandsData().loadIrCommandsData();
    var selectables =
        commands.commandsList.map((e) => SelectableItem(e.name, e)).toList();
    _selectableList.selectables = selectables;
    return commands;
  }

  Widget makePage(IrCommandsData irCommandsData) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 25,
          child: makeWidgetIrControllerCommandsManager(
              irCommandsData.commandsList),
        ),
        Expanded(
          flex: 75,
          child: makeWidgetPlotWindowWithEdging(_plotWindow.plotWindow),
        ),
      ],
    );
  }

  Widget makeWidgetIrControllerCommandsManager(
      List<IrCommandSequence> commandsList) {
    return Column(
      children: <Widget>[
        createOverflowBar(IrControllerCommandsListOverflowBar()),
        Expanded(
          child: _selectableList.makeListWidget(),
        ),
      ],
    );
  }

  Widget makeWidgetPlotWindowWithEdging(PlotWindow plotWindow) {
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
