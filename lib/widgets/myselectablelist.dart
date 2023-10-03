import 'package:flutter/material.dart';

class SelectableItem<T> {
  String name;
  T item;
  bool isSelected = false;
  SelectableItem(this.name, this.item);
}

class MySelectableList<T> {
  void Function(T sItem)? _select;
  late List<SelectableItem<T>> selectables;

  MySelectableList({void Function(T sItem)? select}) {
    _select = select;
    selectables = List.empty();
  }

  Widget makeListWidget() {
    return ListView(
      children: makeItemsList(),
    );
  }

  List<T> get selectedItems => selectables
      .where((element) => element.isSelected)
      .map((e) => e.item)
      .toList();

  List<Widget> makeItemsList() {
    return selectables.map((e) => makeTappableItem(e)).toList();
  }

  Widget makeTappableItem(SelectableItem<T> sItem) {
    return GestureDetector(
      onTap: () {
        sItem.isSelected = !sItem.isSelected;
        if (_select != null) {
          _select!(sItem.item);
        }
      },
      child: makeItem(sItem),
    );
  }

  Widget makeItem(SelectableItem<T> sItem) {
    return Text(sItem.name,
        style: sItem.isSelected
            ? const TextStyle(fontWeight: FontWeight.bold)
            : const TextStyle(fontWeight: FontWeight.normal));
  }
}
