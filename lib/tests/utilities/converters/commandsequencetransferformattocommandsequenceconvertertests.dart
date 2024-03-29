import 'dart:convert';
import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../../utilities/converters/commandsequencetransferformattocommandsequenceconverter.dart';

class CommandsListFromApiCommandsConverterTests extends TestModule {
  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(codesAreConverter),
    ];
  }

  void codesAreConverter() {
    var jsonCodes = """[
  {
    "code": "3_3times",
    "waveform": [
      {
        "t": 0,
        "v": 0
      },
      {
        "t": 2405,
        "v": 1
      },
      {
        "t": 3005,
        "v": 0
      }
    ]
  }
]""";
    var data = json.decode(jsonCodes);

    var codes = convertCommandSequenceTransferFormatToCommandSequence(data);

    assertEqual(codes.length, 1);
    assertEqual(codes[0].name, "3_3times");
    assertEqual(codes[0].points.length, 3);
    assertEqual(codes[0].points[0].time, 0);
    assertEqual(codes[0].points[0].value, 0);
    assertEqual(codes[0].points[1].time, 2405);
    assertEqual(codes[0].points[1].value, 1);
    assertEqual(codes[0].points[2].time, 3005);
    assertEqual(codes[0].points[2].value, 0);
  }
}
