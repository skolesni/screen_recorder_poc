import 'package:flutter/material.dart';
import 'package:screen_recorder_poc/injection.dart';
import 'package:screen_recorder_poc/view.dart';

/// The main entry point of the application.
void main() {
  configureInjection();

  runApp(const MyApp());
}
