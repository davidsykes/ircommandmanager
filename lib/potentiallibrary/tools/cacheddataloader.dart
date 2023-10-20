import 'cacheddata.dart';

class CachedDataLoader<T> {
  CachedDataX _data;
  Future<T> Function() _retrieveData;
  void Function(T) _onDataLoaded;

  CachedDataLoader(this._data, this._retrieveData, this._onDataLoaded) {
    if (_data.data != null) {
      _onDataLoaded(_data.data! as T);
    }
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
}
