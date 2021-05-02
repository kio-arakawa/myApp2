import 'dart:async';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/view_model/base_view_model.dart';

class HomeViewModel extends BaseViewModel {

  /// Constructor(SingleTon)
  HomeViewModel._();
  static HomeViewModel _homeViewModel;
  static HomeViewModel _instance() => HomeViewModel._();
  factory HomeViewModel() {
    return _homeViewModel ??= _instance();
  }

  ///Variable
  //日付情報
  String _dateTime;
  //曜日情報
  String _dayOfWeek;
  // アクティビティ（年月）
  String activityOfYearAndMonthString;
  // アクティビティ（年月の数値）
  int activityOfYearAndMonthValue;

  /// Method
  // 日時情報取得API
  String getDateTime() {
    initializeDateFormatting('ja');
    _dateTime = DateFormat.yMMMMd('ja').format(DateTime.now()).toString();
    _dayOfWeek = DateFormat.yMEd('ja').format(DateTime.now()).toString();
    return _dayOfWeek;
  }

  // 年月のアクティビティ情報取得 → 更新通知
  void updateActivityInfo() {
    activityOfYearAndMonthString = syncDataBaseModelInstance().getActivityByYearAndMonthFromSync().keys.elementAt(0) ?? '';
    activityOfYearAndMonthValue = syncDataBaseModelInstance().getActivityByYearAndMonthFromSync().values.elementAt(0) ?? 0;
    notifyListeners();
  }

}