import '../../dataobjects/ircommandsequence.dart';
import '../../utilities/converters/commandsequencetransferformattocommandsequenceconverter.dart';
import '../../webservices/webaccess.dart';

class IrCommandsData {
  static const String ipAddress = '192.168.1.142:5001';
  static const String configurationOption = 'configuration.e6614143f';
  //One instance, needs factory
  static IrCommandsData? _instance;
  factory IrCommandsData() => _instance ??= IrCommandsData._();
  IrCommandsData._();

  WebAccess _webAccess = WebAccess(ipAddress);

  Future<List<IrCommandSequence>> loadIrCommandSequences() async {
    var codes = await _webAccess.getJsonWebData('codes');
    commandsList = convertCommandSequenceTransferFormatToCommandSequence(codes);

    return commandsList;
  }

  bool configurationIsRecorder() {
    return configuration == 'irrecorder';
  }

  Future<String> setConfiguration(bool x) async {
    configuration = x ? 'irrecorder' : 'irtransmitter';

    var url = 'setoption?name=configuration.e6614143f502f&value=$configuration';
    var response = await _webAccess.put(url);
    return response;
  }

  Future<List<String>> loadLogData() async {
    var logsJson = await _webAccess.getJsonWebData('logs?count=10');

    var logs = logsJson.map((l) => l['time'] + ' ' + l['text']);

    return logs.toList().cast<String>();
  }

  // TODO Review everything below here

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
    commandsList = convertCommandSequenceTransferFormatToCommandSequence(codes);

    var configuration = await _webAccess
        .getTextWebData('option?option=configuration.e6614143f502f');

    var cd = IrCommandsData();
    cd.commandsList = commandsList;
    cd.configuration = configuration;

    return cd;
  }
}
