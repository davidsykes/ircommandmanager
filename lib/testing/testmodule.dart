import 'dart:convert';
import 'package:ircommandmanager/testing/testunit.dart';

abstract class TestModule {
  Iterable<TestUnit> getTests();

  void setUpObjectUnderTest();

  TestUnit createTest(String description, void Function() action) {
    return TestUnit(testModule: this, description: description, action: action);
  }

  void myAssert(bool value) {
    if (!value) {
      var st = StackTrace.current.toString();
      var ls = LineSplitter().convert(st)[1];
      throw TestAssertFailException(ls);
    }
  }
}

class TestAssertFailException implements Exception {
  String cause;
  TestAssertFailException(this.cause);
}
