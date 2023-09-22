import 'package:ircommandmanager/dataobjects/ircommandsequence.dart';
import '../../dataobjects/traces/tracepoint.dart';

List<IrCommandSequence> convertCommandSequenceTransferFormatToCommandSequence(
    codes) {
  for (var code in codes) {
    _makeIrCommand(code);
  }

  var cmds1 = codes.map((c) => _makeIrCommand(c));
  var cmds2 = cmds1.toList().cast<IrCommandSequence>();

  return cmds2;
}

IrCommandSequence _makeIrCommand(c) {
  IrCommandSequence cmd = IrCommandSequence(c['code']);

  var points = c['waveform'];
  var points1 = points.map((p) => TracePoint(time: p['t'], value: p['v']));
  List<TracePoint> points2 = points1.toList().cast<TracePoint>();
  cmd.values = points2;

  return cmd;
}
