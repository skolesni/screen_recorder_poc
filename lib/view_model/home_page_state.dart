import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Defines the state for the HomePage.
@immutable
final class HomePageState extends Equatable {
  /// The current counter value.
  final int counter;

  /// Creates a new HomePageState with the given counter value.
  const HomePageState({required this.counter});

  /// Creates an initial HomePageState with a counter value of 0.
  const HomePageState.initial() : counter = 0;

  /// Creates a copy of the current HomePageState with optional new values.
  HomePageState copyWith({int? counter}) => HomePageState(
      counter: counter ?? this.counter,
    );

  @override
  List<Object?> get props => [counter];
}
