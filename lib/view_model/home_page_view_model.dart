import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_recorder_poc/abstracts.dart';
import 'package:screen_recorder_poc/view_model/home_page_state.dart';

/// Implements the ViewModel for the HomePage.
/// Mutable
final class HomePageViewModel extends Cubit<HomePageState> {
  final ScreenRecordingService _screenRecordingService;
  Timer? _pollTimer;

  /// Initializes the ViewModel with the given [ScreenRecordingService].
  HomePageViewModel(this._screenRecordingService) : super(const HomePageState.initial()) {
    // In production this should use observable pattern via platform event channels,
    // however, compromised implementation for POC
    _startPollingForRecording();
  }

  /// Starts recording.
  Future<void> startRecording() async {
    emit(state.copyWith(recordingStatus: .startingRecording));

    // Not expecting platform errors in the state layer
    // Error feedback is not a requirements for this POC
    final success = await _screenRecordingService.startRecording();
    final status = success ? VideoRecordingStatus.recording : VideoRecordingStatus.idle;
    emit(state.copyWith(recordingStatus: status));
  }

  /// Shows the existing recording UI. Temporarily sets hasRecording to true upon completion.
  Future<void> showRecording() async {
    emit(state.copyWith(recordingStatus: .showingRecording));

    // Not expecting platform errors in the state layer
    // Error feedback is not a requirements for this POC
    final success = await _screenRecordingService.showRecording();
    final status = success ? VideoRecordingStatus.idle : VideoRecordingStatus.recording;
    emit(state.copyWith(recordingStatus: status));
  }

  /// Plays recording using the native AVPlayerViewController.
  Future<void> playRecording() async {
    emit(state.copyWith(playbackStatus: .playing));

    try {
      await _screenRecordingService.playRecording();
      // Simulate start playback duration, should be wired up with actual playback events in production
      await Future.delayed(const Duration(seconds: 1)); 
    } finally {
      emit(state.copyWith(playbackStatus: .idle));
    }
  }

  @override
  Future<void> close() {
    // Disposing resources
    _pollTimer?.cancel();
    return super.close();
  }

  void _startPollingForRecording() {
    _pollTimer?.cancel();
    _checkForRecording();
    _pollTimer = Timer.periodic(const Duration(seconds: 2), (_) => _checkForRecording());
  }

  Future<void> _checkForRecording() async {
    final exists = await _screenRecordingService.hasRecording();
    if (exists && !state.hasRecording) {
      emit(state.copyWith(hasRecording: true));
    }
  }
}
