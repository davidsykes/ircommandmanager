import 'package:ircommandmanager/testing/testmodule.dart';

class TestUnit {
  TestModule testModule;
  String name;
  String description;
  bool Function() action;

  TestUnit(
      {required this.testModule,
      required this.name,
      required this.description,
      required this.action});

  void setUpObjectUnderTest() {
    testModule.setUpObjectUnderTest();
  }

  runTest() {
    action();
  }
}
