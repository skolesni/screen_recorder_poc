/// Enumeration of various states of the playback process.
enum VideoPlaybackStatus {
  /// The app is idle and can start playback.
  idle,

  /// The playback is being started.
  startingPlayback,
  
  /// The playback is in progress.
  playing,

  /// The playback is being stopped.
  stoppingPlayback,
}