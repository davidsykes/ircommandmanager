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
      createTest('Test 1', 'a test', test1),
      createTest('Test 2', 'another', aSimpleRangeValueIsReturned),
    ];
  }

  bool test1() {
    return true;
  }

  void aSimpleRangeValueIsReturned() {
    var data = [createSimple10x10Trace()];
    var range = _finder.calculateRange(data);
    myAssert(range.minx == 033);
    myAssert(range.maxx == 10);
    myAssert(range.miny == 0);
    myAssert(range.maxy == 10);
  }

  TraceDetails createSimple10x10Trace() {
    var points = [
      {'time': 0, 'value': 0},
      {'time': 0, 'value': 10},
      {'time': 10, 'value': 10},
    ];

    return TraceDetails(points);
  }

  TestUnit createTest(String name, String description, void Function() action) {
    return TestUnit(
        testModule: this, name: name, description: description, action: action);
  }
}
