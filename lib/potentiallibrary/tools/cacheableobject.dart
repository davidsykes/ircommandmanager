class Cacheable<T> {
  T? data;
  Future<T> Function() retrieveData;
  void Function(T) refreshData;

  Cacheable(this.retrieveData, this.refreshData);

  Future<T> getData() async {
    if (data == null) {
      data = await retrieveData();
      if (data != null) {
        refreshData(data as T);
      }
    }
    return data!;
  }
}
