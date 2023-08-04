import '../../testing/testmodule.dart';
import '../../testing/testunit.dart';
import '../../utilities/verticalplotplacer.dart';

const int screenTopCoordinate = 0;
const int screenBottomCoordinate = 200;
const int screenHeight = screenBottomCoordinate - screenTopCoordinate;
const int upperBorderPercentage = 5;
const int lowerBorderPercentage = 5;
const double usableScreenTopCoordinate =
    screenTopCoordinate + screenHeight * upperBorderPercentage / 100;
const double usableScreenBottomCoordinate =
    screenBottomCoordinate - screenHeight * lowerBorderPercentage / 100;

class VerticalPlotPlacerTests extends TestModule {
  late VerticalPlotPlacer _placer;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aSinglePlotIsPlacedWithinTheScreen),
    ];
  }

  void aSinglePlotIsPlacedWithinTheScreen() {
    _placer = VerticalPlotPlacer(screenHeight, 1);
    var values = createSomeValues();

    var newValues = _placer.placePlots(values);

    assertEqual(newValues[0], [1.0, usableScreenBottomCoordinate]);
    assertEqual(newValues[1], [
      2.0,
      ((usableScreenBottomCoordinate + usableScreenTopCoordinate) / 2)
    ]);
    assertEqual(newValues[2], [3.0, usableScreenTopCoordinate]);
  }

  List<List<double>> createSomeValues() {
    return [
      [1, 0],
      [2, 0.5],
      [3, 1],
    ];
  }
}
