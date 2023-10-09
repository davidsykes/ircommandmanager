class ScopeTraceAccess {
  //One instance, needs factory
  static ScopeTraceAccess? _instance;
  factory ScopeTraceAccess() => _instance ??= ScopeTraceAccess._();
  ScopeTraceAccess._();

  int zoom = 1;
  int offset = 0;
  bool showTestPlot = false;
}
