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

      test.setUpObjectUnderTest();
      var result = test.runTest();

      results.add('Test $name result $result');
    }

    return results;
  }
}
