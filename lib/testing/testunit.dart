import 'package:ircommandmanager/testing/testmodule.dart';

class TestUnit {
  TestModule testModule;
  String description;
  void Function() action;

  TestUnit(
      {required this.testModule,
      required this.description,
      required this.action});

  void setUpObjectUnderTest() {
    testModule.setUpObjectUnderTest();
  }

  runTest() {
    action();
  }
}
