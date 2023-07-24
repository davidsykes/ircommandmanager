import '../../dataobjects/tracepoints.dart';
import '../../testing/testmodule.dart';
import '../../testing/testunit.dart';
import '../../utilities/tracevaluerangefinder.dart';

class TraceValueRangeFinderTests extends TestModule {
  late TraceValueRangeFinder _finder;

  @override
  void setUpObjectUnderTest() {
    _finder = TraceValueRangeFinder();
  }

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aSimpleRangeValueIsReturned),
      createTest(aRangeWithNegativesIsReturned),
      createTest(multipleRangesAreCombined),
    ];
  }

  void aSimpleRangeValueIsReturned() {
    var data = [createSimple10x10Trace()];
    var range = _finder.calculateRange(data);
    myAssert(range.minx == 0);
    myAssert(range.maxx == 10);
    myAssert(range.miny == 0);
    myAssert(range.maxy == 10);
  }

  TracePoints createSimple10x10Trace() {
    var points = [
      {'time': 0, 'value': 0},
      {'time': 0, 'value': 10},
      {'time': 10, 'value': 10},
    ];

    return TracePoints.fromJsonPoints(points);
  }

  void aRangeWithNegativesIsReturned() {
    var data = [createSimple10x10TraceWithNegatives()];
    var range = _finder.calculateRange(data);
    myAssert(range.minx == -10);
    myAssert(range.maxx == 5);
    myAssert(range.miny == -10);
    myAssert(range.maxy == 5);
  }

  TracePoints createSimple10x10TraceWithNegatives() {
    var points = [
      {'time': -10, 'value': 0},
      {'time': 0, 'value': 5},
      {'time': 5, 'value': -10},
    ];

    return TracePoints.fromJsonPoints(points);
  }

  void multipleRangesAreCombined() {
    var data = [
      createSimple10x10Trace(),
      createSimple10x10TraceWithNegatives()
    ];
    var range = _finder.calculateRange(data);
    myAssert(range.minx == -10);
    myAssert(range.maxx == 10);
    myAssert(range.miny == -10);
    myAssert(range.maxy == 10);
  }
}
