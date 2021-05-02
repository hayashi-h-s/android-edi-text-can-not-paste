import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_app_firebase/todo.dart';

class AddModel extends ChangeNotifier {
  String todoText = '';

  Future add() async{
    final collection = FirebaseFirestore.instance.collection("todoList");
    // 追加のドキュメント → https://www.youtube.com/watch?v=rR0Zl9-J0JA&list=PLuLRJz1UnJzEQDOEflFsTiWFFgoLQqlK0&index=3&t=406s
    await collection.add({
      'title': todoText,
      'createdAt': Timestamp.now(),
    });
  }
}