// class Glob {
//   //One instance, needs factory
//   static Glob? _instance;
//   factory Glob() => _instance ??= Glob._();
//   Glob._();
//   //

//   String account = 'johanacct1';

//   String getServerUrl() {
//     return 'http://192.168.1.60';
//   }

//   String getAccountUrl() {
//     return '${getServerUrl()}/accounts/$account';
//   }
// }

import '../../dataobjects/ircommand.dart';
import '../../utilities/converters/commandslistfromapicommandsconverter.dart';
import '../../webaccess.dart';

class IrCommandsData {
  //One instance, needs factory
  static IrCommandsData? _instance;
  factory IrCommandsData() => _instance ??= IrCommandsData._();
  IrCommandsData._();

  WebAccess _webAccess = WebAccess('192.168.1.142:5001');

  List<IrCommand> commandsList = List<IrCommand>.empty(growable: true);

  // String account = 'johanacct1';

  // String getServerUrl() {
  //   return 'http://192.168.1.60';
  // }

  // String getAccountUrl() {
  //   return '${getServerUrl()}/accounts/$account';
  // }

  Future<IrCommandsData>? loadIrCommandsDataFuture;
  Future<IrCommandsData> loadIrCommandsData() async {
    loadIrCommandsDataFuture ??= _loadIrCommandsData();
    return await loadIrCommandsDataFuture!;
  }

  Future<IrCommandsData> _loadIrCommandsData() async {
    var codes = await _webAccess.getWebData('codes');
    commandsList = CommandsListFromApiCommandsConverter.convert(codes);

    var cd = IrCommandsData();
    cd.commandsList = commandsList;

    return cd;
  }
}
