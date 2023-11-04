import 'package:flutter/material.dart';
import '../../../../potentiallibrary/widgets/elevatedbutton.dart';
import '../../../../potentiallibrary/widgets/overflowbar.dart';

class IrControllerCommandsListOverflowBar extends IMyOverflowBar {
  void Function() sendButtonPressed;
  void Function() plotButtonPressed;
  void Function() createTest500;

  IrControllerCommandsListOverflowBar(
      this.sendButtonPressed, this.plotButtonPressed, this.createTest500);

  @override
  List<Widget> getChildren() {
    return <Widget>[
      createElevatedButton('Plot', plotButtonPressed),
      createElevatedButton('Send', sendButtonPressed),
      createElevatedButton('Create Test 500', createTest500),
      Text('Something functional'),
      Checkbox(value: true, onChanged: (bool? x) => {}),
    ];
  }
}
