import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dataobjects/selectabletraceinfo.dart';
import 'webaccess.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void xxxxxxdeletethestuffabovehereeeeeeeee() {}

  List<SelectableTraceInfo> traces = List<SelectableTraceInfo>.empty();

  Future<List<SelectableTraceInfo>> getTraceList() async {
    if (traces.isEmpty) {
      var tracedata = await WebAccess.getTraces();
      traces = tracedata
          .map((traceInfo) => SelectableTraceInfo(traceInfo: traceInfo))
          .toList();
    }
    return traces;
  }
}
