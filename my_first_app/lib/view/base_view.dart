import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:my_first_app/state/state_manager.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:my_first_app/view/lifecycle_manager.dart';
import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/view/home_view.dart';
import 'package:my_first_app/view/setting_view.dart';
import 'package:my_first_app/view/diary_view.dart';
import 'package:my_first_app/view/history_view.dart';
import 'package:my_first_app/view/widget/bottom_navigationbar.dart';

class BaseView extends HookWidget {

  ///Constructor(Singleton)
  BaseView._();
  static BaseView _baseView;
  factory BaseView() {
    return _baseView ??= BaseView._();
  }

  ///Variable
  final BaseViewModel _baseViewModel = BaseViewModel();

  ///BottomNavigationBarの遷移ページリスト
  static List<Widget> _pageList = [
    HomeView(),
    DiaryView(),
    HistoryView(),
    SettingView(),
  ];

  void _initializer(BuildContext context) async {
//    _settingViewModel.setContext(context);
    // Dimensクラス初期処理
    DimensManager.dimensHomeSize.initialDimens<HomeView>(context);
    // ユーザー名・パスワードをSyncModelにセット
    await _baseViewModel.syncDataBaseModel.setUserNameIntoSync(_baseViewModel.mySharedPref.getUserName());
    await _baseViewModel.syncDataBaseModel.setUserPassIntoSync(_baseViewModel.mySharedPref.getUserPass());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // OSのテーマカラーをチェック
//      _settingViewModel.setOSDarkTheme(notNotify: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('baseViewBuild');
    //初期設定
    _initializer(context);
    return LifecycleManager(
      // OSのテーマカラーがライトモードになった時
      osLightThemeCallBack: () {
//        _settingViewModel.changeOsDarkMode(false);
      },
      // OSのテーマカラーがダークモードになった時
      osDarkThemeCallBack: () {
//        _settingViewModel.changeOsDarkMode(true);
      },
      child: Container(
        height: DimensManager.dimensHomeSize.fullHeight,
        width: DimensManager.dimensHomeSize.fullWidth,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer(
      builder: (context, watch, _) {
        final baseViewModel = watch(baseViewModelProvider);
        return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: PreferredSize(
            /// ⚠︎Scaffoldのappbarプロパティを使用して、preferredSizeに高さ指定する場合は、StatusBarの高さを考慮しなくても良い
            preferredSize: Size.fromHeight(DimensManager.dimensHomeSize.headerHeight),
            child: AppBar(
              backgroundColor: Colors.blueGrey.withOpacity(0.7),
              centerTitle: true,
              title: Text(baseViewModel.appBarTitle),
              leading: Container(),
            ),
          ),
          body:_pageList[baseViewModel.selectedIndex],
          bottomNavigationBar: BottomNavigationBarItems(),
        );
      },
    );
  }

}
