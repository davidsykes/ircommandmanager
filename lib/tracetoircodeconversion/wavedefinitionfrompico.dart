class WaveDefinitionFromPico {
  late String code;
  late List<List<int>> wavepoints;

  Map<String, dynamic> toJson() => {'code': code, 'wavepoints': wavepoints};
}
