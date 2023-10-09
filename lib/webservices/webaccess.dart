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

    return result.toString();
  }

  Future<String> put(String url) async {
    var result = await http.put(
      Uri.parse(makeUrl(url)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return result.toString();
  }

  void deleteTraces(Iterable<String> tracesToDelete) {
    for (var trace in tracesToDelete) {
      deleteTrace(trace);
    }
  }

  void deleteTrace(String trace) async {
    var result = await http.post(
      Uri.parse(makeUrl('delete/$trace')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(result);
  }
}
