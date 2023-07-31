import 'tracepoints.dart';

class TraceInfo {
  final String name;
  final String fileName;
  final int traceCount;
  final int traceLength;
  TracePoints? traceDetails;

  TraceInfo(
      {required this.name,
      required this.fileName,
      required this.traceCount,
      required this.traceLength});
}
