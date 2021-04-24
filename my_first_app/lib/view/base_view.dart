import 'package:flutter/material.dart';
import 'package:my_first_app/model/sync_data_base_model.dart';
import 'package:my_first_app/model/my_shared_pref.dart';
import 'package:my_first_app/view/lifecycle_manager.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/view/widget/bottom_navigationbar.dart';
import 'package:my_first_app/view/home_view.dart';
import 'package:my_first_app/view/setting_view.dart';
import 'package:my_first_app/view/diary_view.dart';
import 'package:my_first_app/view/history_view.dart';
import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/view_model/setting_view_model.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';

class BaseView extends StatelessWidget {

  ///Constructor(Singleton)
  BaseView._(this._settingViewModel, this._mySharedPref, this._syncDataBaseModel);
  static BaseView _baseView;
  factory BaseView(SettingViewModel settingViewModel, MySharedPref mySharedPref, SyncDataBaseModel syncDataBaseModel) {
    return _baseView ??= BaseView._(settingViewModel, mySharedPref, syncDataBaseModel);
  }

  ///Variable
  final SettingViewModel _settingViewModel;
  final MySharedPref _mySharedPref;
  final SyncDataBaseModel _syncDataBaseModel;
  final LifecycleCallback _lifecycleCallback = LifecycleCallback();

  ///BottomNavigationBarの遷移ページリスト
  static List<Widget> _pageList = [
    HomeView(SettingViewModel()),
    DiaryView(),
    HistoryView(SyncDataBaseModel(), MySharedPref()),
    SettingView(),
  ];

  void _initializer(BuildContext context) async {
    _settingViewModel.setContext(context);
    // Dimensクラス初期処理
    DimensManager.dimensHomeSize.initialDimens<HomeView>(context);
    // ユーザー名・パスワードをSyncModelにセット
    await _syncDataBaseModel.setUserNameIntoSync(_mySharedPref.getUserName());
    await _syncDataBaseModel.setUserPassIntoSync(_mySharedPref.getUserPass());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // OSのテーマカラーをチェック
      _settingViewModel.setOSDarkTheme(notNotify: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('baseViewBuild');
    //初期設定
    _initializer(context);
    return LifecycleManager(
      callback: _lifecycleCallback,
      // OSのテーマカラーがライトモードになった時
      osLightThemeCallBack: () {
        _settingViewModel.changeOsDarkMode(false);
      },
      // OSのテーマカラーがダークモードになった時
      osDarkThemeCallBack: () {
        _settingViewModel.changeOsDarkMode(true);
      },
      child: Container(
        height: DimensManager.dimensHomeSize.fullHeight,
        width: DimensManager.dimensHomeSize.fullWidth,
//      color: Colors.black, //StatusBarとBottomStatusBarの背景色
        child: _settingViewModel.isDebugMode
            ? _debugBuilder()
            : _normalBuilder(),
      ),
    );
  }

  ///本当のbuildメソッドの中身(Debug中は基本的にOFFにして下のbuildメソッドを使用する)
  Widget _normalBuilder() {
    return Consumer<BaseViewModel>(
      builder: (_,model,__) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: PreferredSize(
            /// ⚠︎Scaffoldのappbarプロパティを使用して、preferredSizeに高さ指定する場合は、StatusBarの高さを考慮しなくても良い
            preferredSize: Size.fromHeight(DimensManager.dimensHomeSize.headerHeight),
            child: AppBar(
              backgroundColor: Colors.blueGrey.withOpacity(0.7),
              centerTitle: true,
              title: Text(model.appBarTitle),
              leading: Container(),
            ),
          ),
          body:_pageList[model.selectedIndex],
          bottomNavigationBar: BottomNavigationBarItems(model, _settingViewModel),
        );
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
