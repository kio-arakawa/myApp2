import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:sqflite/sqflite.dart';

import 'package:my_first_app/my_enum/data_base_state.dart';
import 'package:my_first_app/view_model/change_notifier_model.dart';
import 'package:my_first_app/model/moor_db.dart';

class ChatViewModel extends ChangeNotifierModel {

  ///Constructor
  ChatViewModel._() {
    _myDatabase ??= MyDatabase();
  }

  static ChatViewModel _chatViewModel;
  static ChatViewModel _instance() => ChatViewModel._();
  //factory constructor
  factory ChatViewModel() {
    _chatViewModel ??= _instance();
    return _chatViewModel;
  }

  ///Variable
  //データベース
  MyDatabase _myDatabase;
  //登録内容
  String registerStrings;
  //自分が送信したかどうか
  bool _isMyRegisterString = true;
  //上のGetメソッド
  bool get isMyRegister => _isMyRegisterString;
  //リストの数
  // Todo: データベースから日記リストの登録内容を取得し、起動時に全件表示する
  int listIndex = 0;
  //リストのKey
  ValueKey key;
  //データベースから取得したキーと値
  Map<int, String> diaryDataMap = {};
  Future<List<MoorDataBase>> _allData;

  Future <List<MoorDataBase>> getFutureData() async {
    return await _myDatabase.allDiaryEntries;
  }

  //全件取得＋10件以上登録時削除＋結果出力
  void _getAllDiaryData() {
    //全件取得用を用意
    List<MoorDataBase> data;
    _allData = _myDatabase.allDiaryEntries;
    _allData.then((value) {
      //全件取得用に移動
      data = value;
      if (data.length > 10) {
        debugPrint('登録数が10件を超えました。全件削除します。');
        _myDatabase.deleteAllDiary().then((value) {
          //Map初期化
          diaryDataMap = {};
          debugPrint('全件削除完了');
        });
      } else {
        //MapにDBから取得した全件をキーと値の組み合わせでセット
        for (int i = 0; i < data.length; i++) {
          diaryDataMap[i] = data[i].diaryTexts;
        }
        //登録内容全件をコンソールに表示
        debugPrint('総登録内容:$diaryDataMap}');
      }
      debugPrint('現在の登録数:${diaryDataMap.length}件');
    });
  }

  ///登録ボタン押下時API
  void onTapRegisterButton(TextEditingController controller) {
    ///_chatWidgetに入力内容をセット
    registerStrings = controller.value.text;
    ///空文字の時は登録しない（_chatWidgetも生成しないし、変更通知もしない）
    if (registerStrings.isNotEmpty) {
      ///[BEGIN]DB関連の処理
      //データ登録
      _myDatabase.addDiary(
        MoorDataBasesCompanion(
          diaryTexts: Value(registerStrings),
          // Todo:テンションをセットできるようにする
          tension: Value('Good'),
        ),
      );
      //全件取得
      _getAllDiaryData();
      ///[END]DB関連の処理
      //自分で登録した時はTrueにする
      _isMyRegisterString = true;
      //テキストフィールドの文字をクリア
      controller.clear();
      ///変更通知
      notifyListeners();
    }
  }

}