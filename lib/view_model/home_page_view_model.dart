import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_recorder_poc/abstracts.dart';
import 'package:screen_recorder_poc/view_model/home_page_state.dart';

/// Implements the ViewModel for the HomePage.
/// Mutable
final class HomePageViewModel extends Cubit<HomePageState> {

  /// Initializes the ViewModel.
  HomePageViewModel() : super(const HomePageState.initial());

  /// Starts recording
  Future<void> startRecording() async {
    // Simulates starting logic.
    // The intermediate StartingRecording state ensures the UI locking to avoid action on multiple taps.
    emit(state.copyWith(recordingStatus: VideoRecordingStatus.startingRecording));
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(state.copyWith(recordingStatus: VideoRecordingStatus.recording));
  }

  /// Stops recording. Sets hasRecording to true upon completion.
  Future<void> stopRecording() async {
    // Simulates stopping logic.
    // The intermediate StoppingRecording state ensures the UI locking to avoid action on multiple taps.
    emit(state.copyWith(recordingStatus: VideoRecordingStatus.stoppingRecording));
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(state.copyWith(recordingStatus: VideoRecordingStatus.idle, hasRecording: true));
  }

  /// Plays recording.
  Future<void> playRecording() async {
    // Simulates playback logic.
    // The intermediate StartingPlayback state ensures the UI locking to avoid action on multiple taps.
    emit(state.copyWith(playbackStatus: VideoPlaybackStatus.startingPlayback));
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(state.copyWith(playbackStatus: VideoPlaybackStatus.playing));
    await Future<void>.delayed(const Duration(seconds: 3));
    emit(state.copyWith(playbackStatus: VideoPlaybackStatus.stoppingPlayback));
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(state.copyWith(playbackStatus: VideoPlaybackStatus.idle));
  }
}
