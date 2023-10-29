import 'cacheddata.dart';

class CachedDataLoader2<T> {
  late CachedData _data;
  Future<T> Function() _retrieveData;
  void Function(T) _onDataLoaded;

  CachedDataLoader2(this._retrieveData, this._onDataLoaded) {
    _data = CachedData();
  }

  Future<T> getData() async {
    if (_data.data == null) {
      _data.data = await _retrieveData();
      if (_data.data != null) {
        _onDataLoaded(_data.data as T);
      }
    }
    return _data.data!;
  }

  void refresh() {
    _data.data = null;
  }
}
