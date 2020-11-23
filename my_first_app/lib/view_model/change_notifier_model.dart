import 'package:flutter/material.dart';

import 'package:my_first_app/my_enum/data_base_state.dart';
import 'package:my_first_app/model/data_base_model.dart';

abstract class ChangeNotifierModel extends ChangeNotifier with DataBaseModel{

  //HistoryDataBaseの通信状態(初期値STOP)
  DataBaseState _dataBaseState = DataBaseState.STOP;

  //通信状態のGETメソッド
  DataBaseState get getState => _dataBaseState;

  //通信状態変更
  void setState(DataBaseState state) {
    _dataBaseState = state;
  }

  @override
  void dispose() {
    super.dispose();
  }

}