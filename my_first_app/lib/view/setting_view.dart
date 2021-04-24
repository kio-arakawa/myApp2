import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:my_first_app/constants.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:my_first_app/model/app_theme_model.dart';
import 'package:my_first_app/my_enum/data_base_state.dart';
import 'package:my_first_app/state/state_manager.dart';

class SettingView extends HookWidget {

  ///Constructor
  SettingView({Key key}) : super(key: key);

  void _initializer(BuildContext context) {
    DimensManager.dimensSettingViewSize.initialDimens<SettingView>(context);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('settingViewBuild');
    _initializer(context);
    //横画面の時用にSafeAreaでラップ
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Consumer(
            builder: (context, watch, _) {
              final settingViewModel = watch(settingViewModelProvider);
              final baseViewModel = watch(baseViewModelProvider);
              final appThemeModel = watch(appThemeModelProvider);
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                baseViewModel.setState(DataBaseState.STOP);
              });
              return Column(
                children: <Widget>[
                  /// Developer Options
                  _createSectionContainer(
                    section: _createSectionTitle(
                      appThemeModel: appThemeModel,
                      title: 'Developer Options',
                    ),
                    tiles: [
                      // Dark Mode
                      _createListTile(
                        appThemeModel: appThemeModel,
                        isSwitchListTile: true,
                        icon: Icon(
                          Icons.lightbulb_outline,
                          color: appThemeModel.isAppThemeDarkNow() ? Colors.yellow : Colors.black,
                        ),
                        text: 'Dark Mode',
                        value: appThemeModel.isAppThemeDarkNow(),
//                        function: (bool value) => settingViewModel.changeDarkMode(value),
                        function: (bool value) => appThemeModel.changeAppThemeColor(isDarkMode: value),
                      ),
                      // Debug Mode
                      _createListTile(
                        appThemeModel: appThemeModel,
                        isSwitchListTile: true,
                        icon: Icon(
                          Icons.bug_report,
                          color: settingViewModel.isDebugMode ? Colors.green : Colors.black,
                        ),
                        text: 'Debug Mode',
                        value: settingViewModel.isDebugMode,
                        function: (bool value) => settingViewModel.changeDebugMode(value),
                      ),
                    ],
                  ),
                  /// User Setting
                  _createSectionContainer(
                    section: _createSectionTitle(
                      appThemeModel: appThemeModel,
                      title: 'User Setting',
                    ),
                    tiles: [
                      // Profile Setting
                      Hero(
                        tag: Constants.profileHeroAnimTag,
                        child: _createListTile(
                          appThemeModel: appThemeModel,
                          isSwitchListTile: false,
                          icon: Icon(
                            Icons.assignment_ind,
                            color: appThemeModel.isAppThemeDarkNow() ? Colors.black : Colors.black,
                          ),
                          text: 'Setting Profile',
                          function: () {
                            Navigator.pushReplacementNamed(context, '/profile');
                          },
                        ),
                      ),
                      // 日記内容初期化
                      _createListTile(
                        appThemeModel: appThemeModel,
                        isSwitchListTile: false,
                        icon: Icon(
                          Icons.autorenew,
                          color: appThemeModel.isAppThemeDarkNow() ? Colors.black : Colors.black,
                        ),
                        text: 'Diary Information Initialization',
                        function: null,
                      ),
                      // LogOut
                      _createListTile(
                        appThemeModel: appThemeModel,
                        isSwitchListTile: false,
                        icon: Icon(
                          Icons.logout,
                          color: appThemeModel.isAppThemeDarkNow() ? Colors.black: Colors.black,
                        ),
                        text: 'Log Out',
                        function: () {
                          print('ログアウトしました！');
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      ),
                    ],
                  ),
                  /// Other
                  _createSectionContainer(
                    section: _createSectionTitle(
                      appThemeModel: appThemeModel,
                      title: 'Other',
                    ),
                    tiles: [
                      _createListTile(
                        appThemeModel: appThemeModel,
                        isSwitchListTile: false,
                        icon: Icon(
                          Icons.help,
                          color: appThemeModel.isAppThemeDarkNow() ? Colors.black : Colors.black,
                        ),
                        text: 'Help',
                        function: null,
                      ),
                    ]
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  ///Sectionごとのまとまりを生成
  Widget _createSectionContainer({Widget section, List<Widget> tiles}) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        left: 2.0,
        right: 2.0,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1.0,
            blurRadius: 10.0,
            offset: Offset(10, 10),
          ),
        ],
      ),
      child: Card(
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            section,
            Column(
              children: tiles,
            ),
          ],
        ),
      ),
    );
  }

  ///SectionTitleを生成
  Widget _createSectionTitle({AppThemeModel appThemeModel, String title}) {
    return Container(
        margin: EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        width: 400,
        child: Text(
          title,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: appThemeModel.isAppThemeDarkNow() ? Colors.black : Colors.black,
//          decoration: TextDecoration.underline,
//          decorationStyle: TextDecorationStyle.dotted,
          ),
        )
    );
  }

  ///NormalListTileまたはSwitchListTileを生成
  Widget _createListTile({
    AppThemeModel appThemeModel,
    bool isSwitchListTile,
    Icon icon,
    Icon subIcon,
    String text,
    bool value,
    Function function,
  }) {
    if (isSwitchListTile) {
      ///Create SwitchListTile
      return Container(
        height: 64,
        margin: EdgeInsets.only(
          left: 4.0,
          right: 4.0,
        ),
        child: Card(
          color: Colors.white70,
          child: SwitchListTile(
            secondary: FittedBox(child: icon),
            activeColor: Colors.orange,
            activeTrackColor: Colors.grey,
            inactiveTrackColor: Colors.grey,
            value: value,
            title: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: appThemeModel.isAppThemeDarkNow() ? Colors.black : Colors.black,
                fontSize: 18,
              ),
            ),
            onChanged: function,
          ),
        ),
      );
    } else {
      ///Create NormalListTile
      return Container(
        height: 64,
        margin: EdgeInsets.only(
          left: 4.0,
          right: 4.0,
        ),
        child: Card(
          color: Colors.white70,
          child: ListTile(
            leading: FittedBox(child: icon),
            trailing: FittedBox(
              child: Icon(
                Icons.chevron_right,
                color: appThemeModel.isAppThemeDarkNow() ? Colors.black : Colors.black,
            ),
            ),
            title: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: appThemeModel.isAppThemeDarkNow() ? Colors.black : Colors.black,
                fontSize: 18,
              ),
            ),
            onTap: function,
          ),
        ),
      );
    }
  }

}