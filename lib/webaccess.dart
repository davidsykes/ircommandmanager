import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dataobjects/traceinfo.dart';

class WebAccess {
  static Future<List<TraceInfo>> getTraces() async {
    final httpPackageUrl = Uri.parse('http://192.168.1.142:5000/tracenames');
    final httpPackageInfo = await http.read(httpPackageUrl);
    final decoded = json.decode(httpPackageInfo);

    var traces = List<TraceInfo>.empty(growable: true);

    for (var trace in decoded) {
      traces.add(TraceInfo(
          name: trace['tracename'],
          fileName: trace['tracepath'],
          traceCount: trace['tracecount'],
          traceLength: trace['tracelength']));
    }

    return traces;
  }

  static void deleteTraces(Iterable<String> tracesToDelete) {
    for (var trace in tracesToDelete) {
      deleteTrace(trace);
    }
  }

  static void deleteTrace(String trace) async {
    var result = await http.post(
      Uri.parse('http://192.168.1.142:5000/delete/$trace'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(result);
  }
}
