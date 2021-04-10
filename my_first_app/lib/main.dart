import 'package:flutter/material.dart';
import 'package:my_first_app/model/animation_model.dart';
import 'package:my_first_app/model/sync_data_base_model.dart';
import 'package:my_first_app/view/profile_view.dart';
import 'package:my_first_app/view_model/history_view_model.dart';
import 'package:my_first_app/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/view/login_view.dart';
import 'package:my_first_app/view/base_view.dart';
import 'package:my_first_app/view/home_view.dart';
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
        ChangeNotifierProvider(create: (context) => HistoryViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (context) => AnimationModel()),
      ],
      child: MyApp(UserInfoData(), SyncDataBaseModel()),
    ),
  );
}

class MyApp extends StatelessWidget {

  ///Variable
  //ユーザー情報のリポジトリmodel(SharedPreferences)
  final UserInfoData _userInfoDataModel;
  final SyncDataBaseModel _syncDataBaseModel;

  MyApp(this._userInfoDataModel, this._syncDataBaseModel) {
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
//            routes: <String, WidgetBuilder> {
//              '/': (BuildContext context) => LoginView(settingViewModel),
//              '/base': (BuildContext context) => BaseView(settingViewModel, _userInfoDataModel),
//              '/profile': (BuildContext context) => ProfileView(),
//            },
            // Info: routesからonGenerateRouteに移行 → Navigator.pushNamedで画面遷移アニメーションするため
            onGenerateRoute: (settings) {
              switch(settings.name) {
                case '/':
                  return PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginView(settingViewModel, _syncDataBaseModel, LoginViewModel(), AnimationModel()),
                  );
                case '/base':
                  return PageRouteBuilder(
                    pageBuilder: (_, __, ___) => BaseView(settingViewModel, _userInfoDataModel, _syncDataBaseModel),
                    transitionDuration: Duration(milliseconds: 600),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    }
                  );
                case '/home' :
                  return PageRouteBuilder(
                    pageBuilder: (_, __, ___) => HomeView(),
                    transitionDuration: Duration(milliseconds: 500),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    }
                  );
                case '/profile':
                  return PageRouteBuilder(
                    pageBuilder: (_, __, ___) => ProfileView(_syncDataBaseModel),
                    transitionDuration: Duration(milliseconds: 500),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    }
                  );
                default:
                  return PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginView(settingViewModel, _syncDataBaseModel, LoginViewModel(), AnimationModel()),
                    transitionDuration: Duration(milliseconds: 500),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    }
                  );
              }
            },
          );
        },
      ),
    );
  }

}