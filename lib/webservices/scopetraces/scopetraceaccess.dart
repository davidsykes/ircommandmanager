import 'package:ircommandmanager/webservices/webaccess.dart';
import '../../utilities/itracedatacontroller.dart';
import '../../utilities/tracedatacontoller.dart';

class ScopeTraceAccess {
  //One instance, needs factory
  static ScopeTraceAccess? _instance;
  factory ScopeTraceAccess() => _instance ??= ScopeTraceAccess._();
  ScopeTraceAccess._() {
    _webAccess = WebAccess('192.168.1.142:5000');
  }

  late WebAccess _webAccess;
  ITraceDataController? actualTraceDataController;

  ITraceDataController getTraceDataController() {
    actualTraceDataController ??= TraceDataController(webAccess: _webAccess);
    return actualTraceDataController!;
  }

  void deleteTraces(Iterable<String> tracesToDelete) {
    getTraceDataController().deleteTraces(tracesToDelete);
  }
}
