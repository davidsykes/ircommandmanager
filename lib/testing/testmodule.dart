import 'dart:convert';
import 'package:ircommandmanager/testing/testunit.dart';

abstract class TestModule {
  Iterable<TestUnit> getTests();

  void setUpObjectUnderTest();

  TestUnit createTest(void Function() action) {
    return TestUnit(testModule: this, action: action);
  }

  void myAssert(bool value) {
    if (!value) {
      throwAssert();
    }
  }

  void assertEqual(dynamic a, dynamic b) {
    var aj = json.encode(a);
    var bj = json.encode(b);
    if (aj != bj) {
      print('A!= $a $b');
      print('AJ!= $aj');
      print('AJ!= $bj');
      throwAssert();
    }
  }

  void throwAssert() {
    var st = StackTrace.current.toString();
    var ls = LineSplitter().convert(st)[2];
    throw TestAssertFailException(ls);
  }
}

class TestAssertFailException implements Exception {
  String cause;
  TestAssertFailException(this.cause);
}
