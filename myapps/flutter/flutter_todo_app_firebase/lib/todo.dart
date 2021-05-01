import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  Todo(DocumentSnapshot doc) {
    this.title = doc.data()["title"];
    // ↓TimestampをDateクラスに変換している
    final Timestamp timestamp = doc.data()["createdAt"];
    this.createdAt = timestamp.toDate();
  }

  String title;
  DateTime createdAt;
}
