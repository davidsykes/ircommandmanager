import 'dart:convert';
import 'package:http/http.dart' as http;

class TraceInfo {
  final String name;
  final String fileName;
  final int traceCount;
  final int traceLength;

  TraceInfo(
      {required this.name,
      required this.fileName,
      required this.traceCount,
      required this.traceLength});
}

class WebAccess {
  static Future<List<TraceInfo>> getPlots() async {
    // final httpPackageUrl = Uri.https('dart.dev', '/f/packages/http.json');
    final httpPackageUrl = Uri.parse('http://192.168.1.142:5000/tracenames');
    final httpPackageInfo = await http.read(httpPackageUrl);
    final decoded = json.decode(httpPackageInfo);

    var traces = List<TraceInfo>.empty(growable: true);

    for (var trace in decoded) {
      //print(trace);
      traces.add(TraceInfo(
          name: trace['tracename'],
          fileName: trace['tracepath'],
          traceCount: trace['tracecount'],
          traceLength: trace['tracelength']));
    }

    return traces;
  }
}
