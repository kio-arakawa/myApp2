import 'dart:async';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:my_first_app/view_model/change_notifier_model.dart';

class HomeViewModel extends ChangeNotifierModel{

  ///Constructor
  //private constructor
  HomeViewModel._();

  static HomeViewModel _instance() => HomeViewModel._();

  factory HomeViewModel() => _instance();

  ///Variable
  //日付情報
  String _dateTime;
  //曜日情報
  String _dayOfWeek;

  //日時情報取得API
  String getDateTime() {
//    _dayTimer();
    initializeDateFormatting('ja');
    _dateTime = DateFormat.yMMMMd('ja').format(DateTime.now()).toString();
    _dayOfWeek = DateFormat.yMEd('ja').format(DateTime.now()).toString();
    return _dayOfWeek;
//    return _dateTime;
  }

//  void _dayTimer() {
//    Timer.periodic(
//      Duration(seconds: 1),
//      _createDateTimeNow,
//    );
//  }

  void _createDateTimeNow(Timer timer) {
    initializeDateFormatting('ja');
    _dateTime = DateFormat.yMMM('ja').format(DateTime.now()).toString();
  }

}