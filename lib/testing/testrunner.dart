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

    for (final test in tests) {
      var description = test.description;

      try {
        test.setUpObjectUnderTest();
        test.runTest();

        results.add('Pass: $description');
      } on TestAssertFailException {
        results.add('Fail: $description');
      } on Exception catch (e) {
        // Anything else that is an exception
        results.add('Unknown exception: $e');
      } catch (e) {
        // No specified type, handles all
        results.add('Something really re unknown: $e ($description)');
      }
    }

    return results;
  }
}
