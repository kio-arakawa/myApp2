import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_first_app/my_enum/data_base_state.dart';
import 'package:my_first_app/state/state_manager.dart';

import 'package:my_first_app/constants.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:my_first_app/view/widget/custom_card_widget.dart';
import 'package:my_first_app/view_model/home_view_model.dart';

class HomeView extends HookWidget {

  ///Constructor
  HomeView();

  void _initializer(BuildContext context, HomeViewModel homeViewModel) {
    DimensManager.dimensHomeSize.initialDimens<HomeView>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = useProvider(homeViewModelProvider);
    final baseViewModel = useProvider(baseViewModelProvider);
    final appThemeModel = useProvider(appThemeModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      baseViewModel.setState(DataBaseState.STOP);
    });
    debugPrint('homeViewBuild');
    //初期設定
    _initializer(context, homeViewModel);
    //LoginViewに戻さない
    return WillPopScope(
      onWillPop: () async => true,
      //横画面の時用にSafeAreaでラップ
      child: SafeArea(
        child: Container(
          color: appThemeModel.isAppThemeDarkNow() ? Colors.black : Colors.white,
          height: DimensManager.dimensHomeSize.fullHeight,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  /// 日付表示
                  _buildTodayText(homeViewModel),
                  /// プロフィールカード
                  // Info: Heroアニメーション付き
                  _buildProfileCard(context, homeViewModel),
                  /// アクティビティ
                  _buildActivityCard(context, homeViewModel),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTodayText(HomeViewModel homeViewModel) {
    return CustomCardWidget(
      isCard: false,
      cardColor: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.calendar_today_sharp,
          ),
          Text(
            '  ${homeViewModel.getDateTime()}',
            style: TextStyle(
              //                                fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, HomeViewModel homeViewModel) {
    return Hero(
      tag: Constants.profileHeroAnimTag,
      child: CupertinoContextMenu(
        actions: [
          CupertinoContextMenuAction(
              child: Center(
                child: Text(
                  '設定',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {
                // MenuActionSheetをpop
                Navigator.pop(context);
                // Profile画面へ画面遷移(With Hero Anim)
                Navigator.pushReplacementNamed(context, '/profile');
              }
          ),
          CupertinoContextMenuAction(
            child: Center(child: Text('戻る', style: TextStyle(fontSize: 15))),
            onPressed: () => Navigator.pop(context),
          )
        ],
        child: CustomCardWidget(
          isCard: true,
          width: 400.0,
          height: 150.0,
          cardColor: Colors.blueGrey.withOpacity(0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // アバター画像
              CircleAvatar(
                minRadius: 40.0,
                maxRadius: 60.0,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                  'assets/avatar_image.png',
                ),
                child: FittedBox(
                  child: Text(
                    'User Image',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              // ProfileUserName
              Container(
                child: Text(
                  '${homeViewModel.syncDataBaseModelInstance().getProfileUserNameFromSync()}',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, HomeViewModel homeViewModel) {
    return CupertinoContextMenu(
      actions: [
        CupertinoContextMenuAction(
            child: Center(
              child: Text(
                '詳細',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onPressed: () {
              // MenuActionSheetをpop
              Navigator.pop(context);
              // Profile画面へ画面遷移(With Hero Anim)
//                Navigator.pushReplacementNamed(context, '/profile');
            }
        ),
        CupertinoContextMenuAction(
          child: Center(child: Text('戻る', style: TextStyle(fontSize: 15))),
          onPressed: () => Navigator.pop(context),
        )
      ],
      child: CustomCardWidget(
        isCard: true,
        width: 400.0,
        height: 150.0,
        cardColor: Colors.grey.withOpacity(0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Activity'),
            Text('${homeViewModel.syncDataBaseModelInstance().getActivityByYearAndMonthFromSync().keys}'
                ':${homeViewModel.syncDataBaseModelInstance().getActivityByYearAndMonthFromSync().values}'),
          ],
        ),
      ),
    );
  }

}