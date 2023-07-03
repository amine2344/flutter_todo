import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/app/app.router.dart';
import 'package:todo_app/services/database_service.dart';
import 'package:todo_app/services/shared_preferences_service.dart';

class AddTodoViewModel extends FutureViewModel<bool> {
  final _dbService = locator<DatabaseService>();
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();
  final _sharedPreferences = locator<SharedPreferencesService>();

  String type = '';
  String category = '';
  bool isLoading = false;

  @override
  Future<bool> futureToRun() async {
    return true;
  }

  @override
  void onData(bool? data) async {
    if(_sharedPreferences.uid == null) {
      await _navigationService.navigateTo(Routes.loginView);
    }
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

  Future<void> addTodo(String title, String description) async {
    isLoading = true;
    notifyListeners();
    try {
      if(title.isEmpty || description.isEmpty || type.isEmpty || category.isEmpty) {
        throw Exception("Please enter valid Title, Description, Type & Category");
      }
      await _dbService.createTodo(title, type, description, category);
      _snackbarService.showSnackbar(message: "Todo created successfully");
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

}