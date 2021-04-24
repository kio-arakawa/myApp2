import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:my_first_app/model/animation_model.dart';
import 'package:my_first_app/model/app_theme_model.dart';
import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/view_model/diary_view_model.dart';
import 'package:my_first_app/view_model/history_view_model.dart';
import 'package:my_first_app/view_model/home_view_model.dart';
import 'package:my_first_app/view_model/login_view_model.dart';
import 'package:my_first_app/view_model/setting_view_model.dart';
import 'package:my_first_app/view_model/profile_view_model.dart';

/// **
/// 各Providerを一元管理するクラス
/// シングルトンなChangeNotifierProviderのインスタンスを返す
/// 各Viewで状態をWatchしていれば、どこからでも部分更新可能になる
/// **

// アプリテーマカラーを管理するProvider
final appThemeModelProvider = ChangeNotifierProvider((ref) => AppThemeModel());
// アニメーションを管理するProvider
final animationModelProvider = ChangeNotifierProvider((ref) => AnimationModel());
// ViewModelを管理するProvider
final baseViewModelProvider = ChangeNotifierProvider((ref) => BaseViewModel());
final loginViewModelProvider = ChangeNotifierProvider((ref) => LoginViewModel());
final homeViewModelProvider = ChangeNotifierProvider((ref) => HomeViewModel());
final diaryViewModelProvider = ChangeNotifierProvider((ref) => ChatViewModel());
final historyViewModelProvider = ChangeNotifierProvider((ref) => HistoryViewModel());
final settingViewModelProvider = ChangeNotifierProvider((ref) => SettingViewModel());
final profileViewModelProvider = ChangeNotifierProvider((ref) => ProfileViewModel());
//