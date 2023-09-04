import 'package:flutter/material.dart';
import '../../../dataobjects/ircommand.dart';
import '../../../utilities/converters/ircommandsequencetoplotsequenceconverter.dart';
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

  static List<Widget> makeIrCommandListWidgets(List<IrCommand> commandsList) {
    List<Widget> widgets = List.empty(growable: true);

    for (var command in commandsList) {
      var widget = GestureDetector(
        onTap: () {
          friday(command);
        },
        child: Text(command.name),
      );
      widgets.add(widget);
    }

    widgets.add(Text(DateTime.now().millisecondsSinceEpoch.toString()));

    return widgets;
  }

  static void friday(IrCommand command) {
    //IrCommandsData().loadIrCommandsData(),
    var plots = IrCommandSequenceToPlotSequenceConverter.convert(command);
    //PlotWindow().SetPlot(plots);
  }
}
