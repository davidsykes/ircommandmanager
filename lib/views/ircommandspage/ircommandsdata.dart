import '../../dataobjects/ircommandsequence.dart';
import '../../utilities/converters/commandsequencetransferformattocommandsequenceconverter.dart';
import '../../webaccess.dart';

class IrCommandsData {
  //One instance, needs factory
  static IrCommandsData? _instance;
  factory IrCommandsData() => _instance ??= IrCommandsData._();
  IrCommandsData._();

  WebAccess _webAccess = WebAccess('192.168.1.142:5001');

  List<IrCommandSequence> commandsList =
      List<IrCommandSequence>.empty(growable: true);

  Future<IrCommandsData>? loadIrCommandsDataFuture;
  Future<IrCommandsData> loadIrCommandsData() async {
    loadIrCommandsDataFuture ??= _loadIrCommandsData();
    return await loadIrCommandsDataFuture!;
  }

  Future<IrCommandsData> _loadIrCommandsData() async {
    var codes = await _webAccess.getWebData('codes');
    commandsList =
        CommandSequenceTransferFormatToCommandSequenceConverter.convert(codes);

    var cd = IrCommandsData();
    cd.commandsList = commandsList;

    return cd;
  }
}
