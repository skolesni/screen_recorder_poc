import 'dart:io';

import 'package:screen_recorder_poc/abstracts.dart';

/// Implementation of [StorageService] using dart:io.
final class StorageServiceImpl implements StorageService {
  /// Creates a const instance of [StorageServiceImpl].
  const StorageServiceImpl();

  @override
  Future<bool> fileExists(String path) => File(path).exists();
}
