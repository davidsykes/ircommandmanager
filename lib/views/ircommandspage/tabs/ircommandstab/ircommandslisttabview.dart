import 'package:flutter/material.dart';
import '../../../../dataobjects/ircommandsequence.dart';
import '../../../../dataobjects/traces/tracepoint.dart';
import '../../ircommandsdata.dart';
import 'ircommandsplotwindow.dart';

class IrCommandsListTabView {
  static Widget getWidgets() {
    return FutureBuilder(
      future: IrCommandsData().loadIrCommandsData(),
      builder: (BuildContext context, AsyncSnapshot<IrCommandsData> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          return makePage(snapshot.data!);
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
    );
  }

  static Widget makePage(IrCommandsData irCommandsData) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 25,
          child: ListView(
            children: makeIrCommandListWidgets(irCommandsData.commandsList),
          ),
        ),
        Expanded(
          flex: 75,
          child: CustomPaint(
            size: Size.infinite,
            painter: IrCommandsPlotWindow().plotWindow,
          ),
        ),
      ],
    );
  }

  static List<Widget> makeIrCommandListWidgets(
      List<IrCommandSequence> commandsList) {
    List<Widget> widgets = List.empty(growable: true);

    for (var command in commandsList) {
      widgets.add(makeTappableWidget(command));
    }

    widgets.add(Text(DateTime.now().millisecondsSinceEpoch.toString()));

    widgets.add(makeTappableWidget(makeTestCommand1()));

    return widgets;
  }

  static void friday(IrCommandSequence command) {
    IrCommandsPlotWindow().showCommand(command);
  }

  static Widget makeTappableWidget(IrCommandSequence command) {
    var widget = GestureDetector(
      onTap: () {
        friday(command);
      },
      child: Text(command.name),
    );
    return widget;
  }

  static IrCommandSequence makeTestCommand1() {
    var cmd = IrCommandSequence('0to10');

    var list = List<int>.generate(11, (i) => i);
    var list2 = list.map((i) => TracePoint(time: i, value: i));
    cmd.values = list2.toList();

    return cmd;
  }
}
