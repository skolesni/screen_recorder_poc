import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_recorder_poc/view_model/home_page_state.dart';

/// Implements the ViewModel for the HomePage.
/// Mutable
final class HomePageViewModel extends Cubit<HomePageState> {

  /// Initializes the ViewModel.
  HomePageViewModel() : super(const HomePageState.initial());

  Future<void> startRecording() async {
    // TODO: Implement in Phase 1
  }

  Future<void> stopRecording() async {
    // TODO: Implement in Phase 2
  }

  Future<void> playRecording() async {
    // TODO: Implement in Phase 3
  }
}
