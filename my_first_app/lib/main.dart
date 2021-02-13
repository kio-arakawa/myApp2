import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/view/login_view.dart';
import 'package:my_first_app/view/base_view.dart';
import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/view_model/diary_view_model.dart';
import 'package:my_first_app/view_model/home_view_model.dart';
import 'package:my_first_app/view_model/setting_view_model.dart';
import 'package:my_first_app/model/data_base_model.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:my_first_app/model/moor_db.dart';
import 'package:my_first_app/model/user_info_data.dart';
import 'package:my_first_app/view_model/login_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => BaseViewModel()),
        ChangeNotifierProvider(create: (context) => SettingViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => ChatViewModel()),
      ],
      child: MyApp(UserInfoData()),
    ),
  );
}

class MyApp extends StatelessWidget {

  ///Variable
  //ユーザー情報のリポジトリmodel(SharedPreferences)
  final UserInfoData _userInfoDataModel;

  MyApp(this._userInfoDataModel) {
    /// DimensManager
    DimensManager();
    /// Diaryデータベースのインスタンス化
    MyDatabase();
    debugPrint('initialDimensManager');
  }

  bool _getAppTheme(BuildContext context) {
    // OSのダークモード設定判定
    //Todo: SharedPrefで初回アプリ起動時以降、Theme設定を記憶しておく
    final Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);
    if (platformBrightness == Brightness.dark) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('MyAppBuild');
    final isDarkMode = _getAppTheme(context);
    return Provider<DataBaseModel>(
      create: (context) => DataBaseModel(),
      dispose: (context, databaseModel) => databaseModel.dispose(),
      child: Consumer<SettingViewModel>(
        builder: (_,settingViewModel,__) {
          return MaterialApp(
            title: 'MyApp',
            theme: isDarkMode ? ThemeData.dark() : settingViewModel.buildTheme(),
            routes: <String, WidgetBuilder> {
              '/': (BuildContext context) => new LoginView(settingViewModel),
              '/base': (BuildContext context) => new BaseView(settingViewModel, _userInfoDataModel),
            },
          );
        },
      ),
    );
  }

}