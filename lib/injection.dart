import 'package:get_it/get_it.dart';
import 'package:screen_recorder_poc/view_model/home_page_view_model.dart';

/// The service locator for dependency injection.
final GetIt locator = GetIt.instance;

/// Configures the dependency injection for the application. 
void configureInjection() {
  // Factories
  locator.registerFactory<HomePageViewModel>(() => HomePageViewModel());
}
