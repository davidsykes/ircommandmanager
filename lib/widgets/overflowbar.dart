import 'package:flutter/material.dart';

abstract class IMyOverflowBar {
  List<Widget> getChildren();
}

Widget createButtonBar(IMyOverflowBar buttonBar) {
  return (OverflowBar(
      alignment: MainAxisAlignment.start, children: buttonBar.getChildren()));
}
