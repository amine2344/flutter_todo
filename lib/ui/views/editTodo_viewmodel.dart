import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/app/app.router.dart';
import 'package:todo_app/datamodels/todo.dart';
import 'package:todo_app/services/database_service.dart';
import 'package:todo_app/services/shared_preferences_service.dart';

class EditTodoViewModel extends FutureViewModel<bool> {
  final _dbService = locator<DatabaseService>();
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();
  final _sharedPreferences = locator<SharedPreferencesService>();
  Todo todo;
  String type = '';
  String category = '';
  bool isLoading = false;
  bool isEditEnabled = false;

  EditTodoViewModel(this.todo);

  @override
  Future<bool> futureToRun() async {
    return true;
  }

  @override
  void onData(bool? data) async {
    if(_sharedPreferences.uid == null) {
      await _navigationService.navigateTo(Routes.loginView);
    }
    type = todo.type;
    category = todo.category;
    notifyListeners();
  }

  void updateType(String typ) {
    type = typ;
    notifyListeners();
  }

  void updateCategory(String cat) {
    category = cat;
    notifyListeners();
  }

  Future<void> updateTodo(String title, String description) async {
    isLoading = true;
    notifyListeners();
    try {
      if(title.isEmpty || description.isEmpty) {
        throw Exception("Please enter valid Title or Description");
      }
      await _dbService.updateTodo(category, type, title, description, todo.todoId);
      _snackbarService.showSnackbar(message: "Todo updated successfully");
      type = '';
      category = '';
      isLoading = false;
      notifyListeners();
      await _navigationService.navigateTo(Routes.homeView);
    }
    catch(err) {
      isLoading = false;
      notifyListeners();
      _snackbarService.showSnackbar(message: err.toString());
    }
  }

  void updateEdit() {
    isEditEnabled = !isEditEnabled;
    notifyListeners();
  }
}