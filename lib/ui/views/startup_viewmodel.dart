import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
    final _navigationService = locator<NavigationService>();
    void navigateToSignup () {
      _navigationService.navigateTo(Routes.signupView);
    }
    void navigateToLogin () {
      _navigationService.navigateTo(Routes.loginView);
    }
    void navigateToHome () {
      _navigationService.navigateTo(Routes.homeView);
    }
}