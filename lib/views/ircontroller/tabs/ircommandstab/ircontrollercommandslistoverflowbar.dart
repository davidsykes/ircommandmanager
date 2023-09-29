import 'package:flutter/material.dart';
import '../../../../widgets/overflowbar.dart';

class IrControllerCommandsListOverflowBar extends IMyOverflowBar {
  @override
  List<Widget> getChildren() {
    return <Widget>[
      Text('Something functional'),
      Checkbox(value: true, onChanged: (bool? x) => {}),
    ];
  }
}
