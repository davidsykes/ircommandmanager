import 'dart:convert';
import 'package:ircommandmanager/tracetoircodeconversion/wavedefinitionfrompico.dart';
import 'package:ircommandmanager/webservices/webaccess.dart';

class IrTransmitterAccess {
  //One instance, needs factory
  late WebAccess _webAccess;

  static IrTransmitterAccess? _instance;
  factory IrTransmitterAccess() => _instance ??= IrTransmitterAccess._();
  IrTransmitterAccess._() {
    _webAccess = WebAccess('192.168.1.142:5001');
  }

  void storeCode(WaveDefinitionFromPico code) async {
    // TODO Check for errors
    var body = jsonEncode(code);
    print(body);
    var result = await _webAccess.put('ircode', body);
    print(result);
  }
}
