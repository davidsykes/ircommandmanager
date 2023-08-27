import 'package:ircommandmanager/dataobjects/ircommand.dart';
import '../../dataobjects/traces/tracepoint.dart';

class CommandsListFromApiCommandsConverter {
  static List<IrCommand> convert(codes) {
    for (var code in codes) {
      _makeIrCommand(code);
    }

    var cmds1 = codes.map((c) => _makeIrCommand(c));
    var cmds2 = cmds1.toList().cast<IrCommand>();

    return cmds2;
  }

  static IrCommand _makeIrCommand(c) {
    IrCommand cmd = IrCommand(c['code']);

    var points = c['waveform'];
    var points1 = points.map((p) => TracePoint(time: p['t'], value: p['v']));
    List<TracePoint> points2 = points1.toList().cast<TracePoint>();
    cmd.points = points2;

    return cmd;
  }
}
