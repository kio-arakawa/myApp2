import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TimeStampType {
  INT_YEAR,
  INT_MONTH,
  INT_DATE,
  STRING_YEAR,
  STRING_MONTH,
  STRING_DATE,
}

/// アクティビティを管理するクラス
///
class ActivityManager {
  /// SingleTon
  ActivityManager._();
  static ActivityManager _activityManager;
  static ActivityManager _instance() => ActivityManager._();
  factory ActivityManager() {
    return _activityManager ??= _instance();
  }

  /// Variable


  /// Method
  // アクティビティ登録時のTimeStampセット
  // timeStampを渡さない場合、DateTime.now()で処理
  // timeStamp以外の名前付き引数のパラメタ指定が１つも無い場合は、yyyy-MM-dd型でtimestampを返す
  dynamic getTimeStamp({String timeStamp, TimeStampType type}) {
    String useTimestamp;
    if(timeStamp == null) {
      // 今の日時情報取得
      final DateTime now = DateTime.now();
      // yyyy-MM-ddでフォーマッティング
      final DateFormat myFormat = DateFormat('yyyy-MM-dd');
      useTimestamp = myFormat.format(now);
    } else {
      useTimestamp= timeStamp;
    }
    // '-'をSplitで、年・月・日の順に分割
    final List<String> timestampList = useTimestamp.split('-');
    // String
    final String nowYearString = timestampList[0];
    final String nowMonthString = timestampList[1];
    final String nowDateString = timestampList[2];
    // Int
    final int nowYear = int.parse(nowYearString);
    final int nowMonth = int.parse(nowMonthString);
    final int nowDate = int.parse(nowDateString);
    if(type != null) {
      switch(type) {
        case TimeStampType.STRING_YEAR:
          return nowYearString;
          break;
        case TimeStampType.STRING_MONTH:
          return nowMonthString;
          break;
        case TimeStampType.STRING_DATE:
          return nowDateString;
          break;
        case TimeStampType.INT_YEAR:
          return nowYear;
          break;
        case TimeStampType.INT_MONTH:
          return nowMonth;
          break;
        case TimeStampType.INT_DATE:
          return nowDate;
          break;
        default:
          return useTimestamp;
          break;
      }
    } else {
      return useTimestamp;
    }
    debugPrint('タイムスタンプ【$nowYear年$nowMonth月$nowDate日】');
  }

  // String型のJsonを受け取って、アップデート
  // →String型のjsonを返す
  getUpdateActivityCountMoldJson(String countJson) {
    final String nowYear = getTimeStamp(type: TimeStampType.STRING_YEAR);
    final String nowMonth = getTimeStamp(type: TimeStampType.STRING_MONTH);
    // Todo:一旦「年月」のKeyのみ管理する
    // Todo:今後は「年月日」「年」の２つを追加予定
    final String jsonKey = '$nowYear年$nowMonth月';
    // 初期値 1
    int newActivity = 1;



//    // 初回登録以外は過去のものをアップデートする必要があるかチェック
//    if(countJson != null) {
//      final oldActivityMap = jsonDecode(countJson);
//      // 同じ年月をキーに、アクティビティカウントを取得
//      int oldActivity = oldActivityMap[jsonKey] as int;
//      // 過去にアクティビティがあればインクリメント
//      if(oldActivity > 0) {
//        // oldをインクリして上書き
//        newActivity = ++oldActivity;
//      }
//    }
//    // String型Jsonデータ作成
//    var jsonString = jsonEncode({ "$jsonKey" : newActivity });
//    debugPrint('json:$jsonString');
//    return jsonString;



    var oldActivityMap;
    // 初回登録以外は過去のものをアップデートする必要があるかチェック
    if(countJson != null) {
      oldActivityMap = jsonDecode(countJson);
      // 同じ年月をキーに、アクティビティカウントを取得
      int oldActivity = oldActivityMap[jsonKey] as int;
      // 過去にアクティビティがあればインクリメント
      if(oldActivity > 0) {
        // oldをインクリして上書き
        newActivity = ++oldActivity;
      }
    }
    oldActivityMap?.update("$jsonKey", (int) => newActivity, ifAbsent: () => newActivity);
    // String型Jsonデータ作成
    var jsonString;
    if(oldActivityMap != null) {
      jsonString = jsonEncode(oldActivityMap);
    } else {
      jsonString = jsonEncode({ "$jsonKey" : newActivity });
    }
    debugPrint('json:$jsonString');
    return jsonString;


  }

  // String型Jsonを受け取ってMapにデコードする
  Map<String, dynamic> decodeStringJson(String stringJson) {
    return jsonDecode(stringJson);
  }

}