import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/services/shared_preferences_service.dart';

class DatabaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final _sharedPreferences = locator<SharedPreferencesService>();
  Future<void> createTodo(String title, String type, String description, String category) async {
    DocumentReference<Map<String, dynamic>> todoDoc = db.collection('todos').doc();
    await db.collection('todos').doc(todoDoc.id).set({
      "title": title,
      "type": type,
      "description": description,
      "category": category,
      "completedStatus": false,
      "createdAt": DateTime.now(),
      "updatedAt": DateTime.now(),
      "userId": _sharedPreferences.uid,
      "todoId": todoDoc.id
    });
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getTodos(String? userId) async {
    QuerySnapshot<Map<String, dynamic>> todos =  await db.collection('todos').where('userId', isEqualTo: userId).get();
    return todos.docs;
  }

  Future<void> updateTodo(String category, String type, String title, String description, String todoId) async {
    await db.collection('todos').doc(todoId).update({
      'category': category,
      'type': type,
      'title': title,
      'description': description,
      'updatedAt': DateTime.now()
    });
  }
}