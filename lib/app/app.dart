import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/services/shared_preferences_service.dart';
import 'package:todo_app/ui/views/home_view.dart';
import 'package:todo_app/ui/views/login_view.dart';
import 'package:todo_app/ui/views/phoneAuth_view.dart';
import 'package:todo_app/ui/views/signup_view.dart';
import 'package:todo_app/ui/views/startup_view.dart';

import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
@StackedApp(
  routes: [
    MaterialRoute(page: StartUpView, initial: true),
    CupertinoRoute(page: HomeView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: PhoneAuthView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: SharedPreferencesService),

  ],
)
class AppSetUp {}