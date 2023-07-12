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
      createTest('Test 2', 'another', test1),
    ];
  }

  static bool test1() {
    return true;
  }

  TestUnit createTest(String name, String description, bool Function() action) {
    return TestUnit(
        testModule: this, name: name, description: description, action: action);
  }
}
