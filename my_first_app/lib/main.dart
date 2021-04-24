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
import 'package:my_first_app/model/my_shared_pref.dart';
import 'package:my_first_app/view_model/login_view_model.dart';

void main() async {
  // Info: main関数で非同期処理をする時のおまじない
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPrefからテーマカラーを非同期で取得 → 完了後にrunApp()
  await MySharedPref().getDarkModeFlag().then((isDarkMode) {
    // フラグがnullなら同期クラスにセットしない
    if (isDarkMode != null) {
      // 同期クラスに保存
      SyncDataBaseModel().setDarkModeFlagIntoSync(isDarkMode);
    }
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
        child: MyApp(MySharedPref(), SyncDataBaseModel(), isDarkMode ??= false),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  ///Variable
  // SharedPrefのリポジトリmodel(SharedPreferences)
  final MySharedPref _mySharedPref;
  final SyncDataBaseModel _syncDataBaseModel;
  final bool _isDarkMode;

  MyApp(this._mySharedPref, this._syncDataBaseModel, this._isDarkMode) {
    /// DimensManager
    DimensManager();
    /// Diaryデータベースのインスタンス化_
  }

  @override
  Widget build(BuildContext context) {
    // テーマ判定フラグ
    bool isDarkTheme;
    return Provider<DataBaseModel>(
      create: (context) => DataBaseModel(),
      dispose: (context, databaseModel) => databaseModel.dispose(),
      child: Consumer<SettingViewModel>(
        builder: (_,settingViewModel,__) {
          // アプリがmain関数を通らないことを示すフラグを設定
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (settingViewModel.isFirstApp) {
              settingViewModel.setIsFirstAppFlag(false);
            }
          });
          // アプリ起動時はSharedPrefから読み込んだフラグを優先的に登録する
          if(!settingViewModel.isFirstApp) {
            if (!settingViewModel.isOSDarkMode) {
              isDarkTheme = settingViewModel.isDarkMode;
            } else {
              isDarkTheme = settingViewModel.isOSDarkMode;
              _syncDataBaseModel.setDarkModeFlagIntoSync(isDarkTheme);
            }
          } else {
            isDarkTheme = _isDarkMode;
            settingViewModel.setIsOsDarkModeFlag(isDarkTheme);
          }
          return MaterialApp(
            title: 'MyApp',
            theme: isDarkTheme ? ThemeData.dark() : settingViewModel.buildTheme(),
            // Info: routesからonGenerateRouteに移行 → Navigator.pushNamedで画面遷移アニメーションするため
            onGenerateRoute: (settings) {
              switch(settings.name) {
                case '/':
                  return PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginView(settingViewModel, _syncDataBaseModel, LoginViewModel(), AnimationModel(), _mySharedPref),
                  );
                case '/base':
                  return PageRouteBuilder(
                    pageBuilder: (_, __, ___) => BaseView(settingViewModel, _mySharedPref, _syncDataBaseModel),
                    transitionDuration: Duration(milliseconds: 600),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    }
                  );
                case '/home' :
                  return PageRouteBuilder(
                    pageBuilder: (_, __, ___) => HomeView(SettingViewModel()),
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
                    pageBuilder: (_, __, ___) => LoginView(settingViewModel, _syncDataBaseModel, LoginViewModel(), AnimationModel(), _mySharedPref),
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