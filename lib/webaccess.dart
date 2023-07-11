import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ircommandmanager/dataobjects/tracedetails.dart';
import 'dataobjects/traceinfo.dart';

class WebAccess {
  late String ipAddress;

  WebAccess(String ip) {
    ipAddress = ip;
  }

  String makeUrl(String u) {
    return 'http://$ipAddress/$u';
  }

  Future<List<TraceInfo>> getTraces() async {
    final httpPackageUrl = Uri.parse(makeUrl('tracenames'));
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

  Future<TraceDetails> getTraceDetails(String fileName) async {
    final httpPackageUrl = Uri.parse(makeUrl('trace/$fileName'));
    final httpPackageInfo = await http.read(httpPackageUrl);
    final rawPoints = json.decode(httpPackageInfo);

    TraceDetails td = TraceDetails(rawPoints);
    print('Get trace details for $fileName');
    return td;
  }
}
