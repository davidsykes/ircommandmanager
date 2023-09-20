import '../../dataobjects/ircommandsequence.dart';
import '../../utilities/converters/commandsequencetransferformattocommandsequenceconverter.dart';
import '../../webaccess.dart';

class IrCommandsData {
  static const String ipAddress = '192.168.1.142:5001';
  static const String configurationOption = 'configuration.e6614143f';
  //One instance, needs factory
  static IrCommandsData? _instance;
  factory IrCommandsData() => _instance ??= IrCommandsData._();
  IrCommandsData._();

  WebAccess _webAccess = WebAccess(ipAddress);

  List<IrCommandSequence> commandsList =
      List<IrCommandSequence>.empty(growable: true);
  String configuration = 'unknown';

  Future<IrCommandsData>? loadIrCommandsDataFuture;
  Future<IrCommandsData> loadIrCommandsData() async {
    loadIrCommandsDataFuture ??= _loadIrCommandsData();
    return await loadIrCommandsDataFuture!;
  }

  Future<IrCommandsData> _loadIrCommandsData() async {
    var codes = await _webAccess.getJsonWebData('codes');
    commandsList =
        CommandSequenceTransferFormatToCommandSequenceConverter.convert(codes);

    var configuration =
        await _webAccess.getTextWebData('option?option=sfdfsdf');

    var cd = IrCommandsData();
    cd.commandsList = commandsList;
    cd.configuration = configuration;

    return cd;
  }

  bool configurationIsRecorder() {
    return configuration == 'SDSD';
  }

  void setConfiguration(bool x) {
    configuration = x ? 'SDSD' : 'yrytyuyu';
  }
}
