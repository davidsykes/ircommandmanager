import 'package:ircommandmanager/testing/testunit.dart';

abstract class TestModule {
  Iterable<TestUnit> getTests();

  void setUpObjectUnderTest();

  void myAssert(bool value) {
    if (!value) {
      throw 'out of llamas';
    }
  }
}
