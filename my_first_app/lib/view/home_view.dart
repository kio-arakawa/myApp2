import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/view/lifecycle_manager.dart';
import 'package:my_first_app/view_model/setting_view_model.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:my_first_app/view/widget/custom_card_widget.dart';
import 'package:my_first_app/view_model/home_view_model.dart';
import 'package:my_first_app/constants.dart';

class HomeView extends StatelessWidget {

  final LifecycleCallback _lifecycleCallback = LifecycleCallback();
  final SettingViewModel _settingViewModel;

  ///Constructor
  HomeView(this._settingViewModel);

  void _initializer(BuildContext context) {
    DimensManager.dimensHomeSize.initialDimens<HomeView>(context);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('homeViewBuild');
    //初期設定
    _initializer(context);
    //LoginViewに戻さない
    return WillPopScope(
      onWillPop: () async => true,
      //横画面の時用にSafeAreaでラップ
      child: SafeArea(
        child: Container(
          height: DimensManager.dimensHomeSize.fullHeight,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ///日付表示
                  Consumer<HomeViewModel>(
                    builder: (_,model,__) {
                      // contextをセット
                      model.setContext(context);
                      return CustomCardWidget(
                        isCard: false,
                        cardColor: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.access_alarms,
                            ),
                            Text(
                              '  ${model.getDateTime()}',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ///プロフィールカード
                  // Info: Heroアニメーション
                  Hero(
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
                          children: <Widget>[
                            CircleAvatar(
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
                              minRadius: 40.0,
                              maxRadius: 60.0,
                              backgroundColor: Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}