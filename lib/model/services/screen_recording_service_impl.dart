import 'package:screen_recorder_poc/abstracts.dart';
import 'package:screen_recorder_poc/model/platform/screen_recording_method_channel.dart';

/// Implementation of [ScreenRecordingService] backed by platform channels.
final class ScreenRecordingServiceImpl implements ScreenRecordingService {
  final ScreenRecordingMethodChannel _methodChannel;

  /// Creates an instance with the given [ScreenRecordingMethodChannel].
  ScreenRecordingServiceImpl(this._methodChannel);

  @override
  Future<bool> startRecording() async {
    // Simulate success
    await Future<void>.delayed(const Duration(seconds: 1));
    return true;

    try {
      await _methodChannel.invokeStartRecording();
      return true;
    } on Exception {
      // Detailed error feedback is not a requirements for this POC
      return false;
    }
  }

  @override
  Future<bool> stopRecording() async {
    // Simulate success
    await Future<void>.delayed(const Duration(seconds: 1));
    return true;

    try {
      await _methodChannel.invokeStopRecording();
      return true;
    } on Exception {
      // Detailed error feedback is not a requirements for this POC
      return false;
    }
  }
}
