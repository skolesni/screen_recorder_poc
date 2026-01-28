/// Definition of service responsible for screen recording operations.
abstract interface class ScreenRecordingService {
  /// Starts screen recording.
  /// Returns true on success, false on failure.
  Future<bool> startRecording();

  /// Shows the existing recording UI.
  /// Returns true on success, false on failure.
  Future<bool> showRecording();
}
