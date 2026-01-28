import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_recorder_poc/abstracts.dart';
import 'package:screen_recorder_poc/view_model/home_page_state.dart';

/// Implements the ViewModel for the HomePage.
/// Mutable
final class HomePageViewModel extends Cubit<HomePageState> {
  final ScreenRecordingService _screenRecordingService;

  /// Initializes the ViewModel with the given [ScreenRecordingService].
  HomePageViewModel(this._screenRecordingService) : super(const HomePageState.initial());

  /// Starts recording.
  Future<void> startRecording() async {
    emit(state.copyWith(recordingStatus: .startingRecording));

    // Not expecting platform errors in the state layer
    // Error feedback is not a requirements for this POC
    final success = await _screenRecordingService.startRecording();
    final status = success ? VideoRecordingStatus.recording : VideoRecordingStatus.idle;
    emit(state.copyWith(recordingStatus: status));
  }

  /// Stops recording. Sets hasRecording to true upon completion.
  Future<void> stopRecording() async {
    emit(state.copyWith(recordingStatus: .stoppingRecording));

    // Not expecting platform errors in the state layer
    // Error feedback is not a requirements for this POC
    final success = await _screenRecordingService.stopRecording();
    if (success) {
      emit(state.copyWith(recordingStatus: .idle,hasRecording: true));
    }
    else {
      emit(state.copyWith(recordingStatus: .recording));
    }
  }

  /// Plays recording.
  Future<void> playRecording() async {
    emit(state.copyWith(playbackStatus: VideoPlaybackStatus.startingPlayback));
    
    // Platform playback service is not a requirements for this POC
    // Simulating playback with delays 
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(state.copyWith(playbackStatus: VideoPlaybackStatus.playing));
    await Future<void>.delayed(const Duration(seconds: 3));
    emit(state.copyWith(playbackStatus: VideoPlaybackStatus.stoppingPlayback));
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(state.copyWith(playbackStatus: VideoPlaybackStatus.idle));
  }
}
