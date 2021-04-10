import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/model/data_base_model.dart';
import 'package:my_first_app/model/sync_data_base_model.dart';
import 'package:my_first_app/model/user_info_data.dart';
import 'package:my_first_app/view_model/history_view_model.dart';
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
import 'package:my_first_app/dimens/dimens_manager.dart';

class BaseView extends StatelessWidget {

  ///Constructor(Singleton)
  BaseView._(this._settingViewModel, this._userInfoDataModel, this._syncDataBaseModel);
  static BaseView _baseView;
  factory BaseView(SettingViewModel settingViewModel, UserInfoData userInfoData, SyncDataBaseModel syncDataBaseModel) {
    return _baseView ??= BaseView._(settingViewModel, userInfoData, syncDataBaseModel);
  }

  ///Variable
  final BaseViewModel _baseViewModel = BaseViewModel();
  final SettingViewModel _settingViewModel;
  final UserInfoData _userInfoDataModel;
  final SyncDataBaseModel _syncDataBaseModel;

  ///BottomNavigationBarの遷移ページリスト
  static List<Widget> _pageList = [
    HomeView(),
    DiaryView(),
    HistoryView(SyncDataBaseModel(), UserInfoData()),
    SettingView(),
  ];

  void _initializer(BuildContext context) async {
    // Dimensクラス初期処理
    DimensManager.dimensHomeSize.initialDimens<HomeView>(context);
    // ユーザー名・パスワードをSyncModelにセット
    await _syncDataBaseModel.setUserNameIntoSync(_userInfoDataModel.getUserName());
    await _syncDataBaseModel.setUserPassIntoSync(_userInfoDataModel.getUserPass());
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('baseViewBuild');
    //初期設定
    _initializer(context);
    return Container(
      height: DimensManager.dimensHomeSize.fullHeight,
      width: DimensManager.dimensHomeSize.fullWidth,
//      color: Colors.black, //StatusBarとBottomStatusBarの背景色
      child: _settingViewModel.isDebugMode
          ? _debugBuilder()
          : _normalBuilder(),
    );
  }

  ///本当のbuildメソッドの中身(Debug中は基本的にOFFにして下のbuildメソッドを使用する)
  Widget _normalBuilder() {
    return Consumer<BaseViewModel>(
      builder: (_,model,__) {

        if (model.isFinishSplash == false && _settingViewModel.isInitSplash == true) {
          return SplashView(model,_settingViewModel);

        } else {
          return AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: _settingViewModel.isInitSplash
                ? model.isStartFadeIn ? 1.0 : 0.0
                : 1.0,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              appBar: PreferredSize(
                /// ⚠︎Scaffoldのappbarプロパティを使用して、preferredSizeに高さ指定する場合は、StatusBarの高さを考慮しなくても良い
                preferredSize: Size.fromHeight(DimensManager.dimensHomeSize.headerHeight),
                child: AppBar(
                  backgroundColor: Colors.blueGrey.withOpacity(0.7),
                  centerTitle: true,
                  title: Text(model.appBarTitle),
//                  leading: _baseViewModel.getPageName() == PageName.SETTING
//                      ? null
//                      : Container(),
                  leading: Container(),
                ),
              ),

              body:_pageList[model.selectedIndex],

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
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(DimensManager.dimensHomeSize.headerHeight),
            child: AppBar(
              backgroundColor: Colors.blueGrey.withOpacity(0.7),
              elevation: 10.0,
              centerTitle: true,
              title: Text(model.appBarTitle),
//              leading: _baseViewModel.getPageName() == PageName.SETTING
//                  ? null
//                  : Container(),
             leading: Container(),
            ),
          ),

          body:_pageList[model.selectedIndex],

          bottomNavigationBar: BottomNavigationBarItems(model, _settingViewModel),
        );
      },
    );
  }

}
