import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dataobjects/selectabletraceinfo.dart';
import 'dataobjects/traceinfo.dart';
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

  late Future<List<TraceInfo>> getTraceListFuture;

  MyAppState() {
    getTraceListFuture = WebAccess.getTraces();
  }

  List<SelectableTraceInfo> selectableTraces =
      List<SelectableTraceInfo>.empty();

  Future<List<SelectableTraceInfo>> getSelectableTraceList() async {
    if (selectableTraces.isEmpty) {
      var tracedata = await getTraceListFuture;
      selectableTraces = tracedata
          .map((traceInfo) => SelectableTraceInfo(traceInfo: traceInfo))
          .toList();
    }
    return selectableTraces;
  }

  List<SelectableTraceInfo> getCachedSelectableTraceList() {
    return selectableTraces;
  }
}
