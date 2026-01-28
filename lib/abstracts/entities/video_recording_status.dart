/// Enumeration of various states of the recording process.
enum VideoRecordingStatus {
  /// The app is idle and can start recording.
  idle, 

  /// The recording is being started.
  startingRecording,

  /// The recording is in progress.
  recording,

  /// The existing recording UI is being shown.
  showingRecording,
}