import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/app/app.router.dart';
import 'package:todo_app/services/database_service.dart';

class AddTodoViewModel extends FutureViewModel {
  final _dbService = locator<DatabaseService>();
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();
  String type = '';
  String category = '';

  @override
  Future futureToRun() async {
    return;
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
    try {
      if(title.isEmpty || description.isEmpty) {
        throw Exception("Please enter valid Title or Description");
      }
      await _dbService.createTodo(title, type, description, category);
      _snackbarService.showSnackbar(message: "Todo created successfully");
      type = '';
      category = '';
      notifyListeners();
      await _navigationService.navigateTo(Routes.homeView);
    }
    catch(err) {
      _snackbarService.showSnackbar(message: err.toString());
    }
  }

}