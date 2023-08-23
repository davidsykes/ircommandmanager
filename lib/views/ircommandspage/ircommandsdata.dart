class Glob {
  //One instance, needs factory
  static Glob? _instance;
  factory Glob() => _instance ??= Glob._();
  Glob._();
  //

  String account = 'johanacct1';

  String getServerUrl() {
    return 'http://192.168.1.60';
  }

  String getAccountUrl() {
    return '${getServerUrl()}/accounts/$account';
  }
}

class IrCommandsData {
  //One instance, needs factory
  static IrCommandsData? _instance;
  factory IrCommandsData() => _instance ??= IrCommandsData._();
  IrCommandsData._();

  String account = 'johanacct1';

  String getServerUrl() {
    return 'http://192.168.1.60';
  }

  String getAccountUrl() {
    return '${getServerUrl()}/accounts/$account';
  }

  Future<IrCommandsData>? loadIrCommandsDataFuture;
  Future<IrCommandsData> loadIrCommandsData() async {
    loadIrCommandsDataFuture ??= loadIrCommandsData2();
    return await loadIrCommandsDataFuture!;
  }

  Future<IrCommandsData> loadIrCommandsData2() async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => IrCommandsData(),
    );
  }
}
