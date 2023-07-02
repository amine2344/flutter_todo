import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/app/app.router.dart';
import 'package:todo_app/services/firebase_notification_handler.dart';
import 'package:todo_app/services/shared_preferences_service.dart';

class InitialViewModel extends BaseViewModel {
  final _sharedPreferencesService = locator<SharedPreferencesService>();
  final _navigationService = locator<NavigationService>();
  final _pushNotificationService = locator<PushNotificationService>();
  Future<void> handleStartUpLogic() async {
    await _sharedPreferencesService.initialise();
    await _pushNotificationService.initialise();
    Future.delayed(const Duration(seconds: 2), () async {
      await _navigationService.clearStackAndShow(Routes.homeView);
    });
  }
}