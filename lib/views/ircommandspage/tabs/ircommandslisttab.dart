import 'package:flutter/material.dart';
import 'package:ircommandmanager/dataobjects/ircommand.dart';
import '../ircommandsdata.dart';

class IrCommandsListTab {
  static Widget getWidgets() {
    return FutureBuilder(
      future: IrCommandsData().loadIrCommandsData(),
      builder: (BuildContext context, AsyncSnapshot<IrCommandsData> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          //children = makeTraceViewPage(snapshot.data!);
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
          child: Container(color: Colors.green),
        ),
      ],
    );
  }

  // static void wTXFROMHEREXXXXXX() {}

  // static List<Widget> makeTraceViewPage(IrCommandsData irCommandsData) {
  //   return [
  //     Text('sfdswf3'),
  //     //ListView(children: makeIrCommandListWidgets(irCommandsData.commandsList)),
  //     //makeIrCommandList(irCommandsData.commandsList),
  //   ];
  // }

  // static Widget makeIrCommandList(List<IrCommand> commandsList) {
  //   return Expanded(
  //       child: ListView(children: makeIrCommandListWidgets(commandsList)));
  // }

  static List<Widget> makeIrCommandListWidgets(List<IrCommand> commandsList) {
    List<Widget> widgets = List.empty(growable: true);

    for (var command in commandsList) {
      var widget = SizedBox(width: 2, child: Text(command.name));
      widgets.add(widget);
    }

    widgets.add(Text(DateTime.now().millisecondsSinceEpoch.toString()));

    return widgets;
  }
}
