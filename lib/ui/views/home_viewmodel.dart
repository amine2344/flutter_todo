import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/app/app.router.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends FutureViewModel<bool> {
  final _sanckbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();
  final _sharedPreferences = locator<SharedPreferencesService>();
  final _authService = locator<AuthService>();

  DateTime? currentBackPressTime;


  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      _sanckbarService.showSnackbar(message: "Press again to exit.");
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<void> moveToLogin() async {
    await _navigationService.navigateTo(Routes.loginView);
  }

  @override
  Future<bool> futureToRun() async {
    return true;
  }

  @override
  void onData(bool? data) async {
    if(_sharedPreferences.token == null) {
      await _navigationService.navigateTo(Routes.loginView);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    await _navigationService.clearStackAndShow(Routes.loginView);
  }

  void navigateToAddTodo () {
    _navigationService.navigateTo(Routes.addTodoView);
  }

}