import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/app/app.router.dart';
import 'package:todo_app/datamodels/todo.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/services/database_service.dart';
import 'package:todo_app/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends FutureViewModel<List<QueryDocumentSnapshot<Map<String, dynamic>>>> {
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();
  final _sharedPreferences = locator<SharedPreferencesService>();
  final _authService = locator<AuthService>();
  final _dbService = locator<DatabaseService>();

  DateTime? currentBackPressTime;
  List<Todo> todos = [];
  bool isLoading = true;
  bool moreTodosAvailable = false;
  DocumentSnapshot<Object?>? lastFetchId;


  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      _snackbarService.showSnackbar(message: "Press again to exit.");
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<void> moveToLogin() async {
    await _navigationService.navigateTo(Routes.loginView);
  }

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> futureToRun() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> toads = await _dbService.getTodos(_sharedPreferences.uid, lastFetchId);
    return toads;
  }

  @override
  void onData(List<QueryDocumentSnapshot<Map<String, dynamic>>>? data) async {
    super.onData(data);
    if(_sharedPreferences.uid == null) {
      await _navigationService.navigateTo(Routes.loginView);
    }
    todos = [];
    if(data!.length <8) {
      moreTodosAvailable = false;
      notifyListeners();
    }
    else {
      moreTodosAvailable = true;
      notifyListeners();
    }
    for (var todo in data) {
      lastFetchId = todo;
      todos.add(Todo.fromJson(todo.data()));
    }
    isLoading = false;
    notifyListeners();
  }

  @override
  void onError(error) {
    super.onError(error);
    isLoading = false;
    _snackbarService.showSnackbar(message: error.toString());
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    await _navigationService.clearStackAndShow(Routes.loginView);
  }

  Future<void> getTodos() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> toads = await _dbService.getTodos(_sharedPreferences.uid, lastFetchId);
    if(toads.length <8) {
      moreTodosAvailable = false;
      notifyListeners();
    }
    else {
      moreTodosAvailable = true;
      notifyListeners();
    }
    for(var todo in toads) {
      lastFetchId = todo;
      todos.add(Todo.fromJson(todo.data()));
    }
    notifyListeners();
  }

  Future<void> refreshTodos () async {
    todos = [];
    lastFetchId = null;
    isLoading = true;
    notifyListeners();
    await getTodos();
    notifyListeners();
  }

  void navigateToAddTodo () {
    _navigationService.navigateTo(Routes.addTodoView);
  }
  void navigateToEditTodo (Todo todo) {
    _navigationService.navigateTo(Routes.editTodoView, arguments: EditTodoViewArguments(todo: todo));
  }
}