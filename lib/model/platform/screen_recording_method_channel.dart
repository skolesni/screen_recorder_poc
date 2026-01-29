import 'package:flutter/services.dart';

/// Platform channel wrapper for native screen recording operations.
final class ScreenRecordingMethodChannel {
  static const _channel = MethodChannel('com.kixapp.poc/recording');

  /// Invokes the native startRecording method.
  Future<void> invokeStartRecording() => _channel.invokeMethod<void>('startRecording');

  /// Invokes the native showRecording method.
  Future<void> invokeShowRecording() => _channel.invokeMethod<void>('showRecording');

  /// Returns the App Group container path, or null if unavailable.
  Future<String?> invokeGetAppGroupPath() => _channel.invokeMethod<String>('getAppGroupPath');
}
