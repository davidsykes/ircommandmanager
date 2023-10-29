import 'package:flutter/material.dart';
import '../../../../potentiallibrary/widgets/elevatedbutton.dart';
import '../../../../potentiallibrary/widgets/overflowbar.dart';

class IrControllerCommandsListOverflowBar extends IMyOverflowBar {
  void Function() sendButtonPressed;
  void Function() plotButtonPressed;

  IrControllerCommandsListOverflowBar(
      this.sendButtonPressed, this.plotButtonPressed);

  @override
  List<Widget> getChildren() {
    return <Widget>[
      createElevatedButton('Plot', plotButtonPressed),
      createElevatedButton('Send', sendButtonPressed),
      Text('Something functional'),
      Checkbox(value: true, onChanged: (bool? x) => {}),
    ];
  }
}
