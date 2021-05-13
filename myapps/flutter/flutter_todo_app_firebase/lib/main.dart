import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app_firebase/add/add_page.dart';
import 'package:flutter_todo_app_firebase/main_model.dart';
import 'package:provider/provider.dart';

import 'add/add_model.dart';

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
      // マテリアルアップは先頭だけでいい→
      title: "TODOアプリ",
      home:
          MaimPage(), // MaimPage()クラスとして分割しないとエラーになる → https://qiita.com/hanach/items/5a1a1133727eb99a10aa
    );
  }
}


//
// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _State();
//   }
// }
enum Menu { google_sign_in, firestore_cloud_vision }


class MaimPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel()..getTodoListRealtime(), // メインモデルのTodoListを取得
      child: Scaffold(
        appBar: AppBar(
          title: Text("TODO アプリだよね"),
          actions: <Widget>[
            Consumer<MainModel>(builder: (context, model, child) {
              final isActive = model.checkShouldActiveCompleteButton();
              return FlatButton(
                onPressed: isActive
                    ? () async {
                        model.deleteCheckedItems();
                      }
                    : null,
                child: Text(
                  "完了",
                  style: TextStyle(
                    // 色を白にしている
                    color: isActive
                        ? Colors.white
                        : Colors.white.withOpacity(0.5), // 透明度
                  ),
                ),
              );
            }),
          ],
        ),
        body: Consumer<MainModel>(
          builder: (context, model, child) {
            final todoList = model.todoList;
            return ListView(
              children: todoList
                  .map(
                    (todo) => _todoItem(
                      // チェックボックを追加
                      todo.title,
                      Icon(Icons.more_vert),
                    ),
                  )
                  .toList(),
            );
          },
        ),
        floatingActionButton:
            Consumer<MainModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              // 画面遷移
              // await Navigator.push(1
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AddPage(),
              //     fullscreenDialog: true, // 画面遷移のアニメーション
              //   ),
              // );

              // ダイアログ
              showDialog(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SimpleDialog(
                      title: Text("Todoの追加"),
                      children: <Widget>[
                        // コンテンツ領域
                        StreamBuilder<Object>(
                            stream: null,
                            builder: (context, snapshot) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: "追加するTODO",
                                    hintText: "例：ゴミを出す",
                                  ),
                                  onChanged: (text) {
                                    // 入力したテキストを取得してモデルに代入
                                    model.todoText = text;
                                  },
                                ),
                              );
                            }),
                        Row(
                          children: [
                            FlatButton(
                              onPressed: () {
                                model.add();
                                Navigator.pop(context);
                              },
                              child: Text("キャンセル"),
                            ),
                            FlatButton(
                              onPressed: () {
                                model.add();
                                Navigator.pop(context);
                              },
                              child: Text("追加"),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }

  Widget _todoItem(String title, Icon icon) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 両端に寄せる
            children: <Widget>[
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: icon,
              ),
              PopupMenuButton(
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<Menu>>[
                  const PopupMenuItem( child: const ListTile( leading:Icon(Icons.supervisor_account),
                      title:Text("Google Sign In")), value: Menu.google_sign_in),
                  const PopupMenuItem( child: const ListTile( leading:Icon(Icons.crop_original),
                      title:Text("Firestore,CloudVision")), value: Menu.firestore_cloud_vision,),
                ],
              ),
            ],
          )),
      onTap: () {
        print("onTap called.");
      },
    );
  }
}
