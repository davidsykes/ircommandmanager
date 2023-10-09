import '../../dataobjects/traces/traceinfo.dart';
import '../../dataobjects/traces/tracesdata.dart';
import '../../testframework/testmodule.dart';
import '../../testframework/testunit.dart';

class TracesDataTests extends TestModule {
  late TracesData _data;

  @override
  void setUpObjectUnderTest() {
    _data = createTestTracesData();
  }

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(allTracesCanBeRetrieved),
      createTest(tracesCanBeSelected),
    ];
  }

  void allTracesCanBeRetrieved() {
    var traces = _data.getAllTraces();

    assertTrue(traces.length == 3);
    assertTrue(!traces[0].isSelected());
    assertTrue(!traces[1].isSelected());
    assertTrue(!traces[2].isSelected());
  }

  void tracesCanBeSelected() {
    var traceNames = _data
        .getAllTraces()
        .where((trace) => !trace.isSelected())
        .map((trace) => trace.traceInfo.fileName)
        .toList();

    assertEqual(traceNames, ['file', 'file', 'file']);
  }

  TracesData createTestTracesData() {
    List<TraceInfo> traces = [
      createTestTraceInfo(),
      createTestTraceInfo(),
      createTestTraceInfo(),
    ];

    return TracesData(traces);
  }

  TraceInfo createTestTraceInfo() {
    return TraceInfo(
        name: 'name', fileName: 'file', traceCount: 1, traceLength: 1);
  }
}
