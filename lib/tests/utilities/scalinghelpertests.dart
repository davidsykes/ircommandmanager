import '../../testing/testmodule.dart';
import '../../testing/testunit.dart';
import '../../utilities/scalinghelper.dart';

class ScalingHelperTests extends TestModule {
  late ScalingHelper _helper;

  @override
  void setUpObjectUnderTest() {
    _helper = ScalingHelper(horizontalExtent: 100, verticalExtent: 100);
  }

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(
          'The maximum y value is calculated', theMaximumYValueIsCalculated),
    ];
  }

  void theMaximumYValueIsCalculated() {
    List<List<List<double>>> values = [
      [
        [0.0, 0],
        [1, 1]
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

    var max = _helper.getMaximumYValue(values);

    assertEqual(max, 10);
  }
}
