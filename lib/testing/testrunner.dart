import 'package:ircommandmanager/testing/testmodule.dart';
import 'package:ircommandmanager/testing/testunit.dart';

class TestRunner {
  List<TestUnit> tests = List.empty(growable: true);

  void addTests(TestModule testModule) {
    var newTests = testModule.getTests();
    tests.addAll(newTests);
  }

  List<String> runTests() {
    List<String> results = List.empty(growable: true);
    var numberOfPassingTests = 0;

    for (final test in tests) {
      try {
        test.setUpObjectUnderTest();
        test.runTest();
        numberOfPassingTests++;
      } on TestAssertFailException catch (e) {
        var cause = e.cause;
        results.add('Fail: $cause');
        for (final extraCause in e.causes) {
          results.add(extraCause);
        }
      } on Exception catch (e) {
        // Anything else that is an exception
        results.add('Unknown exception: $e');
      } catch (e) {
        // No specified type, handles all
        results.add('Fail: Unknown error: $e');
      }
    }
    results.add('$numberOfPassingTests tests pass');

    return results;
  }
}
