import 'dart:convert';
import 'package:http/http.dart' as http;

class WebAccess {
  late String ipAddress;

  WebAccess(String ip) {
    ipAddress = ip;
  }

  String makeUrl(String u) {
    return 'http://$ipAddress/$u';
  }

  dynamic getJsonWebData(String url) async {
    final httpPackageUrl = Uri.parse(makeUrl(url));
    final httpPackageInfo = await http.read(httpPackageUrl);
    final decoded = json.decode(httpPackageInfo);
    return decoded;
  }

  Future<String> getTextWebData(String url) async {
    final httpPackageUrl = Uri.parse(makeUrl(url));
    final httpPackageInfo = await http.read(httpPackageUrl);
    return httpPackageInfo;
  }

  Future<String> post(String url) async {
    var result = await http.post(
      Uri.parse(makeUrl(url)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    var code = result.statusCode;
    var resultBody = result.body;
    return '$code : $resultBody';
  }

  Future<String> put(String url, String? putBody) async {
    var result = await http.put(
      Uri.parse(makeUrl(url)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: putBody,
    );

    var code = result.statusCode;
    var resultBody = result.body;
    return '$code : $resultBody';
  }
}
