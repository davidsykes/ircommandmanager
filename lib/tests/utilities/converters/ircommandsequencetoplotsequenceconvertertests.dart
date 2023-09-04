import 'package:ircommandmanager/dataobjects/traces/tracepoint.dart';
import '../../../dataobjects/ircommand.dart';
import '../../../testing/testmodule.dart';
import '../../../testing/testunit.dart';
import '../../../utilities/converters/ircommandsequencetoplotsequenceconverter.dart';

class IrCommandSequenceToPlotSequenceConverterTests extends TestModule {
  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aSequenceIsConverted),
    ];
  }

  void aSequenceIsConverted() {
    var commandSequence = createSimpleSequence();

    var sequence =
        IrCommandSequenceToPlotSequenceConverter.convert(commandSequence);
    var plots = sequence.plots;

    assertEqual(plots.length, 7);
    myAssert(plots[0].x == 0);
    myAssert(plots[0].y == 0);
    assertEqual(plots[1].x, 1);
    myAssert(plots[1].y == 0);
    myAssert(plots[2].x == 1);
    myAssert(plots[2].y == 1);
    myAssert(plots[3].x == 2);
    myAssert(plots[3].y == 1);
    myAssert(plots[4].x == 2);
    myAssert(plots[4].y == 0);
    myAssert(plots[5].x == 3);
    myAssert(plots[5].y == 0);
    myAssert(plots[6].x == 3);
    myAssert(plots[6].y == 1);
  }

  IrCommand createSimpleSequence() {
    return createSequence([
      [0, 0],
      [1, 1],
      [2, 0],
      [3, 1]
    ]);
  }

  IrCommand createSequence(List<List<int>> list) {
    var cmd = IrCommand("Command name");
    cmd.points = list.map((p) => TracePoint(time: p[0], value: p[1])).toList();
    return cmd;
  }
}