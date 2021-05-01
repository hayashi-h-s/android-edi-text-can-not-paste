import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app_firebase/main_model.dart';
import 'package:provider/provider.dart';

void main() async {
  // これを呼ばないとFireStoreを呼び出せない
  WidgetsFlutterBinding.ensureInitialized(); // ← わからん
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "TODOアプリ",
        home: ChangeNotifierProvider<MainModel>(
          create: (_) => MainModel()..getTodoListRealtime(), // メインモデルのTodoListを取得
          child: Scaffold(
            appBar: AppBar(
              title: Text("TODO アプリだよね"),
            ),
            body: Consumer<MainModel>(
              builder: (context, model, child) {
                final todoList = model.todoList;
                return ListView(
                  children: todoList
                      .map((todo) => ListTile(
                            title: Text(todo.title),
                          ))
                      .toList(),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
            ),
          ),
        ));
  }
}
