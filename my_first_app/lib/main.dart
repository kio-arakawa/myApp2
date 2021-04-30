import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:my_first_app/state/state_manager.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:my_first_app/model/db/my_shared_pref.dart';
import 'package:my_first_app/model/sync_data_base_model.dart';
import 'package:my_first_app/view/profile_view.dart';
import 'package:my_first_app/view/login_view.dart';
import 'package:my_first_app/view/base_view.dart';
import 'package:my_first_app/view/home_view.dart';

void main() async {
  // Info: main関数で非同期処理をする時のおまじない
  WidgetsFlutterBinding.ensureInitialized();
//  // SharedPrefからテーマカラーを非同期で取得 → 完了後にrunApp()
//  await MySharedPref().getDarkModeFlag().then((isDarkMode) {
//    // フラグがnullなら同期クラスにセットしない
//    if (isDarkMode != null) {
//      // 同期クラスに保存
//      SyncDataBaseModel().setDarkModeFlagIntoSync(isDarkMode);
//    }
//    runApp(
//      ProviderScope(
//        child: MyApp(isDarkMode ??= false),
//      ),
//    );
//  });
  await multiInitFutureFunc().then((isDarkMode) {
    runApp(
      ProviderScope(
        child: MyApp(isDarkMode ??= false),
      ),
    );
  });
}

Future<bool> multiInitFutureFunc() async {
  bool isDarkModeFlag;
  await Future.wait([
    // ダークモードFlagの読み込み
    MySharedPref().getDarkModeFlag().then((isDarkMode) {
      // フラグがnullなら同期クラスにセットしない
      if (isDarkMode != null) {
        // 同期クラスに保存
        SyncDataBaseModel().setDarkModeFlagIntoSync(isDarkMode);
        isDarkModeFlag = isDarkMode;
      }
    }),
    // アプリ初回起動Flagの読み込み
    MySharedPref().getInitAppLaunce().then((isInitAppLaunch) {
      // フラグがnullなら同期クラスにセットしない
      if (isInitAppLaunch != null) {
        SyncDataBaseModel().setInitAppLaunchFlagIntoSync(isInitAppLaunch);
      }
    }),

  ]);
  return isDarkModeFlag;
}

class MyApp extends HookWidget {
  ///Variable
  // SharedPrefから読み込んだダークモードフラグ
  final bool _isDarkMode;

  MyApp(this._isDarkMode) {
    /// DimensManager
    DimensManager();
  }

  void _initializer(BuildContext context) {
    // アプリテーマ管理Providerを呼び出し
    // Info: useContextがnullになるのは（＝使えなくなる）、buildメソッドが完了した時
    final appThemeModel = useProvider(appThemeModelProvider);
    final Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);
    if (appThemeModel.isNeedFirstThemeCheck) {
      if ( (platformBrightness == Brightness.dark) || _isDarkMode ) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          appThemeModel.changeAppThemeColor(data: ThemeData.dark());
        });
      }
      appThemeModel.isNeedFirstThemeCheck = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _initializer(context);
    return Consumer(
      builder: (context, watch, _) {
        final appThemeModel = watch(appThemeModelProvider);
        return MaterialApp(
          title: 'MyApp',
          theme: appThemeModel.appThemeData,
          // Info: routesからonGenerateRouteに移行 → Navigator.pushNamedで画面遷移アニメーションするため
          onGenerateRoute: (settings) {
            switch(settings.name) {
              case '/':
                return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => LoginView(),
                );
          case '/base':
            return PageRouteBuilder(
                pageBuilder: (_, __, ___) => BaseView(),
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
                pageBuilder: (_, __, ___) => ProfileView(),
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                }
            );
              default:
                return PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginView(),
                    transitionDuration: Duration(milliseconds: 500),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    }
                );
            }
          },
        );
      },
    );
  }
}