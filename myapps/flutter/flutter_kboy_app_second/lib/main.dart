import 'package:flutter/material.dart';
import 'package:flutter_kboy_app_second/next_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "TODOアプリ",
        home: Scaffold(
          appBar: AppBar(
            title: Text("TODO アプリだよ"),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 上下左右中央に配置
            children: <Widget>[Text("ボディだよ")],
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
            },
            child: Icon(Icons.add),
          ),
        ));
  }
}
