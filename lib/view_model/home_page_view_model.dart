import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_recorder_poc/view_model/home_page_state.dart';

/// Implements the ViewModel for the HomePage.
/// Mutable
final class HomePageViewModel extends Cubit<HomePageState> {

  /// Initializes the ViewModel with an initial counter value of 0.
  HomePageViewModel() : super(const HomePageState.initial());

  /// Increments the counter by 1.
  void incrementCounter() => emit(state.copyWith(counter: state.counter + 1));
}
