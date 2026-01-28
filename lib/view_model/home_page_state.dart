import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Defines the state of the HomePage.
@immutable
final class HomePageState extends Equatable {
  /// Indicates whether there is a recording available.
  final bool hasRecording;

  /// Indicates whether recording is in progress.
  final bool isRecording;

  /// Indicates whether playback is in progress.
  final bool isPlaying;

  /// Creates a new HomePageState with the given values.
  const HomePageState({this.hasRecording = false, this.isRecording = false, this.isPlaying = false});

  /// Creates an initial HomePageState.
  const HomePageState.initial() : hasRecording = false, isRecording = false, isPlaying = false;

  /// Indicates whether the system is busy (recording or playing).
  bool get isBusy => isRecording || isPlaying;

  /// Creates a copy of the current HomePageState with optional new values.
  HomePageState copyWith({bool? hasRecording, bool? isRecording, bool? isPlaying}) => HomePageState(
      hasRecording: hasRecording ?? this.hasRecording,
      isRecording: isRecording ?? this.isRecording,
      isPlaying: isPlaying ?? this.isPlaying,
    );

  @override
  List<Object?> get props => [hasRecording, isRecording, isPlaying];
}
