import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:my_first_app/my_enum/data_base_state.dart';
import 'package:my_first_app/state/state_manager.dart';

class HistoryView extends HookWidget {

  ///Constructor
  HistoryView();

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
        child: Consumer(
          builder: (context, watch, _) {
            final historyViewModel = watch(historyViewModelProvider);
            final baseViewModel = watch(baseViewModelProvider);
            final appThemeModel = watch(appThemeModelProvider);
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              baseViewModel.setState(DataBaseState.STOP);
            });
            return Container(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'ユーザー名：${historyViewModel.syncDataBaseModel.getUserNameFromSync()}',
                        style: TextStyle(
                          fontSize: 20,
                          color: appThemeModel.isAppThemeDarkNow() ? Colors.white : Colors.black
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'パスワード：${historyViewModel.syncDataBaseModel.getUserPassFromSync()}',
                        style: TextStyle(
                            fontSize: 20,
                            color: appThemeModel.isAppThemeDarkNow() ? Colors.white : Colors.black
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '今ダークモード？：${appThemeModel.isAppThemeDarkNow()}',
                        style: TextStyle(
                            fontSize: 20,
                            color: appThemeModel.isAppThemeDarkNow() ? Colors.white : Colors.black
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'OSはダークモード？：${historyViewModel.isOSDarkMode}',
                        style: TextStyle(
                            fontSize: 20,
                            color: appThemeModel.isAppThemeDarkNow() ? Colors.white : Colors.black
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