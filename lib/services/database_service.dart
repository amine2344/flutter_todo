import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> createTodo(String title, String type, String description, String category) async {
    await db.collection('todos').add({
      "title": title,
      "type": type,
      "description": description,
      "category": category
    });
  }
}