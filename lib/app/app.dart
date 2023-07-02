import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/services/database_service.dart';
import 'package:todo_app/services/firebase_notification_handler.dart';
import 'package:todo_app/services/notification_manager.dart';
import 'package:todo_app/services/shared_preferences_service.dart';

import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app/ui/views/addTodo_view.dart';
import 'package:todo_app/ui/views/editTodo_view.dart';
import 'package:todo_app/ui/views/home_view.dart';
import 'package:todo_app/ui/views/initial_view.dart';
import 'package:todo_app/ui/views/login_view.dart';
import 'package:todo_app/ui/views/phoneAuth_view.dart';
import 'package:todo_app/ui/views/signup_view.dart';
import 'package:todo_app/ui/views/startup_view.dart';
@StackedApp(
  routes: [
    MaterialRoute(page: InitialView, initial: true),
    MaterialRoute(page: StartUpView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: PhoneAuthView),
    MaterialRoute(page: AddTodoView),
    MaterialRoute(page: EditTodoView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: SharedPreferencesService),
    LazySingleton(classType: PushNotificationService),
    LazySingleton(classType: NotificationManager),
    LazySingleton(classType: DatabaseService),
  ],
)
class AppSetUp {}