import 'package:flutter/material.dart';

class FilledBorderedBox extends StatelessWidget {
  final MaterialColor color;

  FilledBorderedBox(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
