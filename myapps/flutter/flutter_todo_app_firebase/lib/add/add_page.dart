import 'package:flutter/material.dart';
import 'package:flutter_todo_app_firebase/add/add_model.dart';
import 'package:provider/provider.dart';

import '../main_model.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    home:
    return ChangeNotifierProvider<AddModel>(
        create: (_) => AddModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("新規追加"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0), // 基本的に８の倍数
            child: Consumer<AddModel>(builder: (context, model, child) {
              return Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "追加するTODO",
                      hintText: "ゴミを出す",
                    ),
                    onChanged: (text) { // 入力したテキストを取得してモデルに代入
                      model.todoText = text;
                    },
                  ),
                  SizedBox(height: 16),
                  RaisedButton(
                    child: Text("ボタンを追加"),
                    onPressed: () async {
                      // FireStoreに値を追加
                      await model.add();
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }),
          ),
        ));
  }
}
