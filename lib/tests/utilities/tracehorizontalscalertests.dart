import '../../forremoval/stuff.dart';
import '../../forremoval/tracehorizontalscaler.dart';
import '../../potentiallibrary/graphs/seriesdata/graphdatapoint.dart';
import '../../testframework/testmodule.dart';
import '../../testframework/testunit.dart';

class TraceHorizontalScalerTests extends TestModule {
  late TraceHorizontalScaler _scaler;

  @override
  void setUpObjectUnderTest() {
    _scaler = TraceHorizontalScaler(screenWidth: 320, zoom: 1, offset: 0);
  }

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(theMaximumXValueIsCalculated),
      createTest(plotsCanBeScaledHorizontally),
      createTest(aZeroHorizontalScaleDoesNothing),
      createTest(plotsCanBeScaledVerticallyToRangeFrom0To1),
    ];
  }

  void theMaximumXValueIsCalculated() {
    var values = createSomeValues();

    var max = _scaler.getMaximumXValue(values);

    assertEqual(max, 5.0);
  }

  void plotsCanBeScaledHorizontally() {
    var values = createSomeValues();

    var max = _scaler.scaleToHorizontalExtent(
        plot: graphDataSeriesToDoubles(values[2]), maxX: 1);

    assertEqual(max, [
      [0.0, 0.0],
      [320.0, 1.0]
    ]);
  }

  void aZeroHorizontalScaleDoesNothing() {
    var values = createSomeValues();

    var max = _scaler.scaleToHorizontalExtent(
        plot: graphDataSeriesToDoubles(values[2]), maxX: 0);

    assertEqual(max, [
      [0.0, 0.0],
      [1.0, 1.0]
    ]);
  }

  void plotsCanBeScaledVerticallyToRangeFrom0To1() {
    List<List<double>> values = [
      [10, 10],
      [10, 11],
      [10, 12],
    ];

    var newValues = _scaler.scalePlotValuesToUnitRange(values);

    assertEqual(newValues[0], [10.0, 0.0]);
    assertEqual(newValues[1], [10.0, 0.5]);
    assertEqual(newValues[2], [10.0, 1.0]);
  }

  List<List<GraphDataPoint>> createSomeValues() {
    return [
      [GraphDataPoint(0, 0), GraphDataPoint(5, 1)],
      [GraphDataPoint(0, 0), GraphDataPoint(1, 10)],
      [GraphDataPoint(0, 0), GraphDataPoint(1, 1)],
    ];
  }
}
