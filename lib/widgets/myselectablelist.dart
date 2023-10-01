import 'package:flutter/material.dart';

abstract class ISelectableItem {
  final String name;
  final dynamic item;
  bool isSelected = false;

  ISelectableItem(this.name, this.item);
}

class SelectableItem extends ISelectableItem {
  SelectableItem(String name, dynamic item) : super(name, item);
}

class MySelectableList {
  void Function(ISelectableItem sItem)? _select;
  late List<ISelectableItem> selectables;

  MySelectableList({void Function(ISelectableItem sItem)? select}) {
    _select = select;
    selectables = List.empty();
  }

  Widget makeListWidget() {
    return ListView(
      children: makeItemsList(),
    );
  }

  List<Widget> makeItemsList() {
    return selectables.map((e) => makeTappableItem(e)).toList();
  }

  Widget makeTappableItem(ISelectableItem sItem) {
    return GestureDetector(
      onTap: () {
        sItem.isSelected = !sItem.isSelected;
        if (_select != null) {
          _select!(sItem);
        }
      },
      child: makeItem(sItem),
    );
  }

  Widget makeItem(ISelectableItem sItem) {
    return Text(sItem.name,
        style: sItem.isSelected
            ? const TextStyle(fontWeight: FontWeight.bold)
            : const TextStyle(fontWeight: FontWeight.normal));
  }
}
