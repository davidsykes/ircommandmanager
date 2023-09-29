import 'package:flutter/material.dart';

Widget createElevatedButton(void Function() onPressed) {
  return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      child: Text('Select All'));
}
