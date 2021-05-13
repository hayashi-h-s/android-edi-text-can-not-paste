import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_app_firebase/todo.dart';

class MainModel extends ChangeNotifier {
  List<Todo> todoList = [];
  String todoText = '';

  Future getTodoList() async { // Futureは非同期処理
    final snapshot =
        await FirebaseFirestore.instance.collection("todoList").get();
    final docs = snapshot.docs;
    final todoList = docs.map((doc) => Todo(doc)).toList();
    this.todoList = todoList;
    notifyListeners();
  }

  void getTodoListRealtime() {
    final snapshot =
        FirebaseFirestore.instance.collection("todoList").snapshots();
    snapshot.listen((snapshot) {
      final docs = snapshot.docs;
      final todoList = docs.map((doc) => Todo(doc)).toList();
      todoList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      this.todoList = todoList;
      notifyListeners();
    });
  }

  void reload() {
    notifyListeners();
  }

  void deleteCheckedItems() async {
    final checkedItems = todoList.where((todo) => todo.isDone).toList(); // whereはtrueだけ残るので、
    final references =
        checkedItems.map((todo) => todo.documentReference).toList(); // ドキュメントリファレンスのlistに変換

    final batch = FirebaseFirestore.instance.batch();

    references.forEach((reference) {
      batch.delete(reference);
    });
    return batch.commit();
  }

  bool checkShouldActiveCompleteButton() {
    final checkedItems = todoList.where((todo) => todo.isDone).toList();
    return checkedItems.length > 0;
  }

  Future add() async{
    final collection = FirebaseFirestore.instance.collection("todoList");
    // 追加のドキュメント → https://www.youtube.com/watch?v=rR0Zl9-J0JA&list=PLuLRJz1UnJzEQDOEflFsTiWFFgoLQqlK0&index=3&t=406s
    await collection.add({
      'title': todoText,
      'createdAt': Timestamp.now(),
    });
  }
}
