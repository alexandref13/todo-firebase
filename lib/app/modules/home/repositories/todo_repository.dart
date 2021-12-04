import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_challenger/app/modules/home/models/todo_model.dart';

import 'todo_repository_interface.dart';

class TodoRepository implements ITodoRepository {
  FirebaseFirestore firestore;

  TodoRepository(this.firestore);

  @override
  Stream<List<TodoModel>> getTodo() {
    return firestore
        .collection('todo')
        .orderBy('position')
        .snapshots()
        .map((query) {
      return query.docs.map((document) {
        return TodoModel.fromDocument(document);
      }).toList();
    });
  }
}
