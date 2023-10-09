import '../../testframework/testmodule.dart';
import '../../testframework/testunit.dart';
import '../../utilities/traceverticalscaler.dart';

class TraceVerticalScalerTests extends TestModule {
  late TraceVerticalScaler _scaler;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aSingleTraceTakesUp90PercentOfTheScreen),
    ];
  }

  void aSingleTraceTakesUp90PercentOfTheScreen() {
    _scaler = TraceVerticalScaler(screenHeight: 100, traceCount: 1);
    var values = createSomeValues();

    var actual = _scaler.scalePlot(0, values);

    assertEqual(actual[0], [1.0, 5.0]);
    assertEqual(actual[1], [2.0, 50.0]);
    assertEqual(actual[2], [3.0, 95.0]);
  }

  List<List<double>> createSomeValues() {
    return [
      [1, 0],
      [2, 0.5],
      [3, 1]
    ];
  }
}
