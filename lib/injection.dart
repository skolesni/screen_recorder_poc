import 'package:get_it/get_it.dart';
import 'package:screen_recorder_poc/abstracts.dart';
import 'package:screen_recorder_poc/model.dart';
import 'package:screen_recorder_poc/view_model/home_page_view_model.dart';

/// The service locator for dependency injection.
final locator = GetIt.instance;

/// Configures the dependency injection for the application.
void configureInjection() {
  // Singletons
  locator.registerLazySingleton<ScreenRecordingMethodChannel>(() => ScreenRecordingMethodChannel());
  locator.registerLazySingleton<StorageService>(() => const StorageServiceImpl());
  locator.registerLazySingleton<ScreenRecordingService>(() => ScreenRecordingServiceImpl(locator(), locator()));

  // Factories
  locator.registerFactory<HomePageViewModel>(() => HomePageViewModel(locator()));
}
