import '../../testing/testmodule.dart';
import '../../testing/testunit.dart';
import '../../utilities/scalinghelper.dart';

class ScalingHelperTests extends TestModule {
  late ScalingHelper _helper;

  @override
  void setUpObjectUnderTest() {
    _helper =
        ScalingHelper(screenWidth: 320, screenHeight: 200, zoom: 1, offset: 0);
  }

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(theMaximumXValueIsCalculated),
      createTest(theMaximumYValueIsCalculated),
      createTest(plotsCanBeScaledHorizontally),
      createTest(plotsCanBeScaledVVerticallyToRangeFrom0To1),
    ];
  }

  void theMaximumXValueIsCalculated() {
    var values = createSomeValues();

    var max = _helper.getMaximumXValue(values);

    assertEqual(max, 5.0);
  }

  void theMaximumYValueIsCalculated() {
    var values = createSomeValues();

    var max = _helper.getMaximumYValue(values);

    assertEqual(max, 10.0);
  }

  void plotsCanBeScaledHorizontally() {
    var values = createSomeValues();

    var max = _helper.scaleToHorizontalExtent(plot: values[2], maxX: 1);

    assertEqual(max, [
      [0.0, 0.0],
      [320.0, 1.0]
    ]);
  }

  void plotsCanBeScaledVVerticallyToRangeFrom0To1() {
    List<List<double>> values = [
      [10, 10],
      [10, 11],
      [10, 12],
    ];

    var newValues = _helper.scalePlotToUnitRange(values);

    assertEqual(newValues[0], [10.0, 0.0]);
    assertEqual(newValues[1], [10.0, 0.5]);
    assertEqual(newValues[2], [10.0, 1.0]);
  }

  List<List<List<double>>> createSomeValues() {
    return [
      [
        [0, 0],
        [5, 1]
      ],
      [
        [0, 0],
        [1, 10]
      ],
      [
        [0, 0],
        [1, 1]
      ],
    ];
  }
}
