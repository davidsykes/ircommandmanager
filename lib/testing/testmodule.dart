import 'dart:convert';
import 'package:ircommandmanager/testing/testunit.dart';

abstract class TestModule {
  Iterable<TestUnit> getTests();

  void setUpObjectUnderTest() {}

  TestUnit createTest(void Function() action) {
    return TestUnit(testModule: this, action: action);
  }

  void myAssert(bool value) {
    if (!value) {
      throwAssert([]);
    }
  }

  void assertEqual(dynamic value, dynamic expected) {
    var vj = json.encode(value);
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
