import 'package:screen_recorder_poc/abstracts.dart';
import 'package:screen_recorder_poc/model/platform/screen_recording_method_channel.dart';

/// Implementation of [ScreenRecordingService] backed by platform channels.
final class ScreenRecordingServiceImpl implements ScreenRecordingService {
  final ScreenRecordingMethodChannel _methodChannel;
  final StorageService _storageService;

  /// Creates an instance with the given [ScreenRecordingMethodChannel].
  const ScreenRecordingServiceImpl(this._methodChannel, this._storageService);

  @override
  Future<bool> startRecording() async {
    try {
      await _methodChannel.invokeStartRecording();
      return true;
    } on Exception {
      // Detailed error feedback is not a requirements for this POC
      return false;
    }
  }

  @override
  Future<bool> showRecording() async {
    try {
      await _methodChannel.invokeShowRecording();
      return true;
    } on Exception {
      // Detailed error feedback is not a requirements for this POC
      return false;
    }
  }

  @override
  Future<bool> hasRecording() async {
    final containerPath = await _methodChannel.invokeGetAppGroupPath();
    if (containerPath == null) {
      return false;
    }

    final path = '$containerPath/Recording001.mp4';
    return await _storageService.fileExists(path);
  }
}
