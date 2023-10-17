import 'package:flutter/material.dart';
import '../../../../potentiallibrary/widgets/elevatedbutton.dart';
import '../../../../potentiallibrary/widgets/overflowbar.dart';

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
