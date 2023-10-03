import 'package:flutter/material.dart';
import '../../../../widgets/elevatedbutton.dart';
import '../../../../widgets/overflowbar.dart';

class IrControllerCommandsListOverflowBar extends IMyOverflowBar {
  void Function() sendButtonPressed;

  IrControllerCommandsListOverflowBar(this.sendButtonPressed);

  @override
  List<Widget> getChildren() {
    return <Widget>[
      createElevatedButton('Send', sendButtonPressed),
      Text('Something functional'),
      Checkbox(value: true, onChanged: (bool? x) => {}),
    ];
  }
}
