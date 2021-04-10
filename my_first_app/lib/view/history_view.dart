import 'package:flutter/material.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:my_first_app/model/sync_data_base_model.dart';
import 'package:my_first_app/model/user_info_data.dart';
import 'package:my_first_app/view_model/history_view_model.dart';
import 'package:provider/provider.dart';

class HistoryView extends StatelessWidget {

  /// Variable
  final SyncDataBaseModel _syncDataBaseModel;
  final UserInfoData _userInfoData;

  ///Constructor
  HistoryView(this._syncDataBaseModel, this._userInfoData);

  void _initializer(BuildContext context) {
    DimensManager.dimensHistoryViewSize.initialDimens<HistoryView>(context);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('historyViewBuild');
    _initializer(context);
    // Info: LoginViewに戻さない
    return WillPopScope(
      onWillPop: () async => true,
      //横画面の時用にSafeAreaでラップ
      child: SafeArea(
        child: Consumer<HistoryViewModel>(
          builder: (_, historyViewModel,__) {
            return Container(
//              height: DimensManager.dimensHistoryViewSize.fullHeight,
//              decoration: BoxDecoration(
//                gradient: LinearGradient(
//                  begin: FractionalOffset.topCenter,
//                  end: FractionalOffset.bottomCenter,
//                  colors: [
//                    Colors.white.withOpacity(1),
//                    Colors.grey.withOpacity(1),
//                  ],
//                ),
//              ),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'ユーザー名：${_syncDataBaseModel.getUserNameFromSync()}',
                        style: TextStyle(
                          fontSize: 20,
                          color: historyViewModel.getIsCurrentDarkMode() ? Colors.white : Colors.black
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'パスワード：${_syncDataBaseModel.getUserPassFromSync()}',
                        style: TextStyle(
                            fontSize: 20,
                            color: historyViewModel.getIsCurrentDarkMode() ? Colors.white : Colors.black
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '今ダークモード？：${historyViewModel.getIsCurrentDarkMode()}',
                        style: TextStyle(
                            fontSize: 20,
                            color: historyViewModel.getIsCurrentDarkMode() ? Colors.white : Colors.black
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}