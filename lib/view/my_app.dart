import 'package:flutter/material.dart';
import 'package:screen_recorder_poc/view.dart';

/// Implements the root widget of the application.
@immutable
final class MyApp extends StatelessWidget {

  /// Creates the root widget of the application.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: .fromSeed(seedColor: Colors.deepPurple),
    ),
    home: const HomePage(),
  );
}
