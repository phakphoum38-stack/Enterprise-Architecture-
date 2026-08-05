class PlatformCapabilities {
  const PlatformCapabilities({
    required this.screenRecording,
    required this.systemAudio,
    required this.applicationControl,
    required this.fileManagement,
    required this.systemSettings,
    required this.adBlocking,
  });

  final bool screenRecording;
  final bool systemAudio;
  final bool applicationControl;
  final bool fileManagement;
  final bool systemSettings;
  final bool adBlocking;

  Map<String, bool> toJson() => <String, bool>{
        'screenRecording': screenRecording,
        'systemAudio': systemAudio,
        'applicationControl': applicationControl,
        'fileManagement': fileManagement,
        'systemSettings': systemSettings,
        'adBlocking': adBlocking,
      };
}

abstract interface class CapabilityDetector {
  Future<PlatformCapabilities> detect();
}
