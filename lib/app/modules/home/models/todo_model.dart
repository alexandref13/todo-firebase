import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String title;
  bool check;
  DocumentReference reference;

  TodoModel({required this.title, this.check = false, required this.reference});

  factory TodoModel.fromDocument(DocumentSnapshot doc) {
    return TodoModel(
      check: doc['check'],
      title: doc['title'],
      reference: doc.reference,
    );
  }
}
