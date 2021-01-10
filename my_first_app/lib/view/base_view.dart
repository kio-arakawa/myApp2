import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/my_enum/page_name.dart';
import 'package:my_first_app/view/widget/bottom_navigationbar.dart';
import 'package:my_first_app/view/home_view.dart';
import 'package:my_first_app/view/splash_view.dart';
import 'package:my_first_app/view/setting_view.dart';
import 'package:my_first_app/view/diary_view.dart';
import 'package:my_first_app/view/history_view.dart';
import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/view_model/setting_view_model.dart';
import 'package:my_first_app/model/user_info.dart';

class BaseView extends StatelessWidget {

  ///Constructor
  BaseView(this._settingViewModel, this._userInfo);

  ///Variable
  BaseViewModel _baseViewModel = BaseViewModel();
  SettingViewModel _settingViewModel;
  UserInfo _userInfo;

  ///BottomNavigationBarの遷移ページリスト
  static List<Widget> _pageList = [
    HomeView(),
    DiaryView(),
    HistoryView(),
    SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    debugPrint('baseViewBuild');
    return _settingViewModel.isDebugMode
        ? _debugBuilder()
        : _normalBuilder();
  }

  ///本当のbuildメソッドの中身(Debug中は基本的にOFFにして下のbuildメソッドを使用する)
  Widget _normalBuilder() {
    return Consumer<BaseViewModel>(
      builder: (_,model,__) {

        if (_baseViewModel.isFinishSplash == false && _settingViewModel.isInitSplash == true) {
          return SplashView(_baseViewModel,_settingViewModel);

        } else {
          return AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: _settingViewModel.isInitSplash
                ? _baseViewModel.isStartFadeIn ? 1.0 : 0.0
                : 1.0,
            child: Scaffold(
              appBar: AppBar(
                title: Text(model.appBarTitle),
                leading: _baseViewModel.getPageName() == PageName.SETTING
                    ? null
                    : Container(),
              ),

              body:SafeArea(child: _pageList[model.selectedIndex]),

              bottomNavigationBar: BottomNavigationBarItems(model, _settingViewModel),
            ),
          );
        }
      },
    );
  }

  /// Debug用のbuildメソッドの中身(リビルドするとSplashViewのアニメーションがうまく動作せずいちいちホットリスタートしなければならないため)
  Widget _debugBuilder() {
    return Consumer<BaseViewModel>(
      builder: (_,model,__) {
        return Scaffold(
          appBar: AppBar(
            title: Text(model.appBarTitle),
            leading: _baseViewModel.getPageName() == PageName.SETTING
                ? null
                : Container(),
          ),

          body:SafeArea(child: _pageList[model.selectedIndex]),

          bottomNavigationBar: BottomNavigationBarItems(model, _settingViewModel),
        );
      },
    );
  }

}
