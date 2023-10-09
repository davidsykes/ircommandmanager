import 'dart:convert';
import 'package:ircommandmanager/testframework/testunit.dart';

abstract class TestModule {
  Iterable<TestUnit> getTests();

  void setUpData() {}
  void setUpMocks() {}
  void setUpObjectUnderTest() {}

  TestUnit createTest(void Function() action) {
    return TestUnit(testModule: this, action: action);
  }

  void assertTrue(bool value) {
    if (!value) {
      throwAssert([]);
    }
  }

  void assertSameObject(dynamic actual, dynamic expected) {
    if (actual != expected) {
      throwAssert(['Expected identical objects']);
    }
  }

  void assertEqual(dynamic actual, dynamic expected) {
    var vj = json.encode(actual);
    var ej = json.encode(expected);
    if (vj != ej) {
      throwAssert(['got $vj', 'Expected $ej']);
    }
  }

  void throwAssert(List<String> causes) {
    var st = StackTrace.current.toString();
    var ls = LineSplitter().convert(st)[2];
    throw TestAssertFailException(ls, causes);
  }
}

class TestAssertFailException implements Exception {
  String cause;
  List<String> causes = List.empty();
  TestAssertFailException(this.cause, this.causes);
}
