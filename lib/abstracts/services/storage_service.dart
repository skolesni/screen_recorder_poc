/// Definition of service responsible for storage access.
abstract interface class StorageService {
  /// Checks if a file exists at the given path.
  /// Returns true if the file exists, false otherwise.
  Future<bool> fileExists(String path);
}
