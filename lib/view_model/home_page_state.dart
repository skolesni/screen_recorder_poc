import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:screen_recorder_poc/abstracts.dart';

/// Defines the state of the HomePage.
@immutable
final class HomePageState extends Equatable {
  /// Indicates whether there is a recording available.
  final bool hasRecording;

  /// The status of the video recording.
  final VideoRecordingStatus recordingStatus;

  /// The status of the video playback.
  final VideoPlaybackStatus playbackStatus;

  /// Creates an initial HomePageState.
  const HomePageState.initial() : hasRecording = false, recordingStatus = .idle, playbackStatus = .idle;

  /// Creates a new HomePageState with the given values.
  const HomePageState({required this.hasRecording, required this.recordingStatus, required this.playbackStatus});

  // Indicates whether the Start button should be visible.
  bool get isStartButtonVisible => recordingStatus == .idle || recordingStatus == .startingRecording;

  // Indicates whether the Stop button should be visible.
  bool get isStopButtonVisible => !isStartButtonVisible;

  // Indicates whether the Play button should be visible.
  bool get isPlayButtonVisible => hasRecording;

  // Indicates whether the Start button is enabled.
  bool get isStartButtonEnabled => recordingStatus == .idle && playbackStatus == .idle;
  
  // Indicates whether the Stop button is enabled.
  bool get isStopButtonEnabled => recordingStatus == .recording;

  // Indicates whether the Play button is enabled.
  bool get isPlayButtonEnabled => recordingStatus == .idle && playbackStatus == .idle;

  /// Creates a copy of the current HomePageState with optional new values.
  HomePageState copyWith({
    bool? hasRecording,
    VideoRecordingStatus? recordingStatus,
    VideoPlaybackStatus? playbackStatus,
  }) => HomePageState(
    hasRecording: hasRecording ?? this.hasRecording,
    recordingStatus: recordingStatus ?? this.recordingStatus,
    playbackStatus: playbackStatus ?? this.playbackStatus,
  );

  @override
  List<Object?> get props => [hasRecording, recordingStatus, playbackStatus];
}
