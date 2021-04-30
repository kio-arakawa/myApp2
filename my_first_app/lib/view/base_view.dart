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
import 'package:my_first_app/view/widget/init_setting_and_tutorial_view.dart';

class BaseView extends HookWidget {

  ///Constructor(Singleton)
//  BaseView._();
//  static BaseView _baseView;
//  factory BaseView() {
//    return _baseView ??= BaseView._();
//  }

  ///BottomNavigationBarの遷移ページリスト
  static List<Widget> _pageList = [
    HomeView(),
    DiaryView(),
    HistoryView(),
    SettingView(),
  ];

  void _initializer(BuildContext context, BaseViewModel baseViewModel) async {
    if(baseViewModel.isInitBaseViewBuild) {
      // Dimensクラス初期処理
      DimensManager.dimensBaseSize.initialDimens<BaseView>(context);
      // ユーザー名・パスワードをSyncModelにセット
      await baseViewModel.syncDataBaseModelInstance().setUserNameIntoSync(baseViewModel.mySharedPrefInstance().getUserName());
      await baseViewModel.syncDataBaseModelInstance().setUserPassIntoSync(baseViewModel.mySharedPrefInstance().getUserPass());
      baseViewModel.setActivity();
      // リビルドされても初期化しないようにセット
      baseViewModel.isInitBaseViewBuild = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseViewModel = useProvider(baseViewModelProvider);
    debugPrint('baseViewBuild');
    //初期設定
    _initializer(context, baseViewModel);
    return Container(
      height: DimensManager.dimensBaseSize.fullHeight,
      width: DimensManager.dimensBaseSize.fullWidth,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildBaseViewBody(baseViewModel),
          // アプリ初回起動時のみ表示
          if(baseViewModel.initAppLaunch)
            InitSettingAndTutorialView(),
        ],
      ),
    );
  }

  Widget _buildBaseViewBody(BaseViewModel baseViewModel) {
    final appThemeModel = useProvider(appThemeModelProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        /// ⚠︎Scaffoldのappbarプロパティを使用して、preferredSizeに高さ指定する場合は、StatusBarの高さを考慮しなくても良い
        preferredSize: Size.fromHeight(DimensManager.dimensBaseSize.headerHeight),
        child: AppBar(
          shadowColor: Colors.grey,
          backgroundColor: appThemeModel.isAppThemeDarkNow() ? Colors.black : Colors.white.withOpacity(0.7),
          centerTitle: true,
          title: Text(
            baseViewModel.appBarTitle,
            style: TextStyle(
              color: appThemeModel.isAppThemeDarkNow() ? Colors.white : Colors.black,
            ),
          ),
          leading: Container(),
        ),
      ),
      body:_pageList[baseViewModel.selectedIndex],
      bottomNavigationBar: BottomNavigationBarItems(),
    );
  }

}
