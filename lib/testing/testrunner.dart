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
      var name = test.name;
      var description = test.description;

      try {
        test.setUpObjectUnderTest();
        var result = test.runTest();

        results.add('Test $name $description resultWW $result');
      } on Exception catch (e) {
        // Anything else that is an exception
        results.add('Unknown exception: $e');
      } catch (e) {
        // No specified type, handles all
        results.add('Something really unknown: $e');
      }
    }

    return results;
  }
}
