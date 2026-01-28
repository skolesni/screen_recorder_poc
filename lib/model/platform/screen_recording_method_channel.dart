import 'package:flutter/services.dart';

/// Platform channel wrapper for native screen recording operations.
final class ScreenRecordingMethodChannel {
  static const _channel = MethodChannel('com.kixapp.poc/recording');

  /// Invokes the native startRecording method.
  Future<void> invokeStartRecording() async {
    await _channel.invokeMethod<void>('startRecording');
  }

  /// Invokes the native stopRecording method.
  Future<void> invokeStopRecording() async {
    await _channel.invokeMethod<void>('stopRecording');
  }
}
