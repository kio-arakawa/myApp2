import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:my_first_app/state/state_manager.dart';
import 'package:my_first_app/view/lifecycle_manager.dart';
import 'package:my_first_app/model/app_theme_model.dart';
import 'package:my_first_app/model/animation_model.dart';
import 'package:my_first_app/view/widget/background_animation.dart';
import 'package:my_first_app/view_model/login_view_model.dart';

class LoginView extends HookWidget {

  ///Constructor
  LoginView();

  ///Variable
  final LoginViewModel _loginViewModel = LoginViewModel();
  final AnimationModel _animationModel = AnimationModel();
  final AppThemeModel _appThemeModel = AppThemeModel();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _initializer(BuildContext context) async {
    debugPrint('loginViewBuild');
    // contextをセット
    _loginViewModel.setContext(context);
    // ユーザー名・パスワードをSyncModelにセット
    await _loginViewModel.syncDataBaseModelInstance().setUserNameIntoSync(_loginViewModel.mySharedPrefInstance().getUserName());
    await _loginViewModel.syncDataBaseModelInstance().setUserPassIntoSync(_loginViewModel.mySharedPrefInstance().getUserPass());
    // CallBack処理
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // BackGroundアニメーション開始
      _animationModel.changeBackGroundAnimationState(BackGroundAnimationState.RUNNING);
      // ログイン情報チェック
      _loginViewModel.checkDoneAll();
      // ユーザー名とパスワードが既に登録済みかチェック
      if (_loginViewModel.syncDataBaseModelInstance().getUserNameFromSync() != null
          || _loginViewModel.syncDataBaseModelInstance().getUserPassFromSync() != null) {
        _loginViewModel.setIsFirstLogin(false);
      }
      // OSのテーマカラーをチェック
//      _settingViewModel.setOSDarkTheme(notNotify: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 初期処理
    _initializer(context);
    return LifecycleManager(
      context: context,
      // OSのテーマカラーがライトモードになった時
      osLightThemeCallBack: () {
//        _appThemeModel.changeAppThemeColor(data: ThemeData.light());
      },
      // OSのテーマカラーがダークモードになった時
      osDarkThemeCallBack: () {
//        _appThemeModel.changeAppThemeColor(data: ThemeData.dark());
      },
      child: _loginViewModel.cacheWidget ??= Scaffold(
        body: Consumer(
          builder: (context, watch, _) {
            /// ここで必要なProviderを全てWatchする
            final loginViewModel = watch(loginViewModelProvider);
            final appThemeModel = watch(appThemeModelProvider);
            final animationModel = watch(animationModelProvider);
            return Stack(
              children: <Widget>[
                // Background Animation
                BackGroundAnimation(animationModel.getBackGroundAnimationState),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50.0,
                    ),
                    child: Center(
                      // キーボード表示時の描画エラー対策
                      child: SingleChildScrollView(
                        child: Column(
                          // Info: 中央揃え
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            /// プロフィール画像
                            _buildUserAvatarImage(),
                            /// ユーザー名入力フィールド
                            _buildUserNameField(context),
                            /// パスワード入力用フィールド
                            _buildUserPassWordField(context),
                            /// ログイン用ボタン
                            Builder(
                              builder: (context) {
                                if(loginViewModel.isDoneAll) {
                                  return _debugBuildLoginButtonWithDeleteAccount(context, true);
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            // Info: Debugモードのみ表示する、ログイン入力ショートカットボタン
                            Builder(
                              builder: (context) {
                                if (loginViewModel.isRegisterAccount) {
                                  return Container();
                                } else {
                                  return RaisedButton(
                                    child: Text('ShortCut'),
                                    textColor: Colors.black,
                                    color: Colors.deepPurpleAccent.withOpacity(0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    //ボタンの影
                                    elevation: 10.0,
                                    //タップ時エフェクト
                                    splashColor: Colors.white,
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(context, '/base');
                                    },
                                  );
                                }
                              }
                            ),
                            /// AppThemeDataChangeButton
//                            RaisedButton(
//                              child: Text('ThemeChange'),
//                              textColor: Colors.black,
//                              color: Colors.teal.withOpacity(0.5),
//                              shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(20.0),
//                              ),
//                              //ボタンの影
//                              elevation: 10.0,
//                              //タップ時エフェクト
//                              splashColor: Colors.white,
//                              onPressed: () {
//                                appThemeModel.changeAppThemeColor();
//                              },
//                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserAvatarImage() {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.0,
      ),
      child: CircleAvatar(
        backgroundImage: AssetImage(
          'assets/avatar_image.png',
        ),
        child: _loginViewModel.isSetImage
            ? null
            : Text(
          'User Image',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        minRadius: 60.0,
        maxRadius: 100.0,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget _buildUserNameField(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'User Name',
        hintText: 'Input your name.',
      ),
      //入力文字数制限
      maxLength: 30,
      //text自動チェック
      autovalidate: true,
      //text値変更時コールバック
      validator: (value) {
        // ユーザー名が空ならエラー
        if (value.isEmpty) {
          _loginViewModel.changeIsDoneName(false);
          return '⚠︎Please enter your name';
        }
        // 空チェックがOKなら
        _loginViewModel.changeIsDoneName(true);
        return null;
      },
      onEditingComplete: () {
        _loginViewModel.setUserName(_nameController.text);
        _loginViewModel.checkDoneAll();
      },
      onFieldSubmitted: (String name) {
        _loginViewModel.setUserName(_nameController.text);
        _loginViewModel.checkDoneAll();
        //Info: キーボードを閉じる
        FocusScope.of(context).unfocus();
      },
      onChanged: (String name) {
        _loginViewModel.setUserName(_nameController.text);
        _loginViewModel.checkDoneAll();
      },
    );
  }

  Widget _buildUserPassWordField(BuildContext context) {
    return TextFormField(
      controller: _passController,
      //入力文字マスキングON
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'User Password',
        hintText: 'Input your password.',
      ),
      //入力文字数制限,
      maxLength: 30,
      //text自動チェック
      autovalidate: true,
      //text値変更時コールバック
      // Info: validatorより、onChangedが先に呼ばれるため、Passが8文字の時はisDoneAllがtrueになっていない状態でnotifyListener呼ばれてしまう
      validator: (value) {
        if (value.isEmpty) {
          _loginViewModel.changeIsDonePass(false);
          return '⚠︎Please enter your password';
          //パスワード入力数8文字以上制限
        } else if (value.length < 8) {
          _loginViewModel.changeIsDonePass(false);
          return '⚠︎Please enter at least 8 characters';
        }
        _loginViewModel.changeIsDonePass(true);
        return null;
      },
      onEditingComplete: () {
        _loginViewModel.setUserPass(_passController.text);
        _loginViewModel.checkDoneAll();
      },
      onFieldSubmitted: (String pass) {
        _loginViewModel.setUserPass(_passController.text);
        _loginViewModel.checkDoneAll();
        // Info: キーボードを閉じる
        FocusScope.of(context).unfocus();
      },
      // Info: validatorより先に呼ばれて、isDoneAllチェックしてしまう
      onChanged: (String pass) {
        _loginViewModel.setUserPass(_passController.text);
        _loginViewModel.checkDoneAll();
      },
    );
  }

  // Todo: リリース時は使用しないこと
  // Info: isIndicateDeleteButton == trueならアカウント削除ボタン表示(Debugモード)
  Widget _debugBuildLoginButtonWithDeleteAccount(
      BuildContext context,
      bool isIndicateDeleteButton,
//      LoginViewModel loginViewModel,
      ) {
    if (isIndicateDeleteButton) {
      return Column(
        children: [
          // 登録・ログインボタン
          _buildCreateAndLoginButton(context),
          // Deleteボタン
          RaisedButton(
            child: Text('Delete Account'),
            textColor: Colors.black,
            color: Colors.red.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            //ボタンの影
            elevation: 10.0,
            //タップ時エフェクト
            splashColor: Colors.white,
            onPressed: () {
              // SharedPrefの登録アカウント情報をクリア
              _loginViewModel.deleteAccount()
                .then((bool) {
                  //　処理成功
                  if (bool) {
                    // 登録済み情報をリセット
                    _loginViewModel.setIsFirstLogin(true);
                    // ユーザー名とパスワードのキャッシュ情報をクリア
                    _loginViewModel.syncDataBaseModelInstance().deleteUserNameFromSync();
                    _loginViewModel.syncDataBaseModelInstance().deleteUserPassFromSync();
                    // 登録用フィールドをクリア
                    _nameController.clear();
                    _passController.clear();
                  // 処理失敗
                  } else {

                  }
              });
            },
          ),
        ],
      );
    } else {
      // 登録・ログインボタン
      return _buildCreateAndLoginButton(context);
    }
  }

  Widget _buildCreateAndLoginButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.0),  //Todo: Stackで絶対位置指定に変更予定
      child: RaisedButton(
        child: Consumer(
          builder: (context, watch, _) {
            if (watch(loginViewModelProvider).isRegisterAccount) {
              return Text('Create');
            } else {
              return Text('Login');
            }
          }
        ),
        textColor: Colors.black,
        color: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        //ボタンの影
        elevation: 10.0,
        //タップ時エフェクト
        splashColor: Colors.white,
        onPressed: () {
          _onTapRegisterOrLoginButton(context);
        },
      ),
    );
  }

  // アカウント登録可否ダイアログ表示
  void _showRegisterAccountDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Center(child: Text('Register User', style: TextStyle(fontSize: 25))),
            content: Text('Are you sure you want to finish user registration?', style: TextStyle(fontSize: 15)),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'No',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  // BackGroundAnimation再開
                  _animationModel.changeBackGroundAnimationState(BackGroundAnimationState.RUNNING);
                  // 自身のダイアログスタック削除
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  _onTapRegisterAccountOkButton(context);
                },
              ),
            ],
          );
        }
    );
  }

  void _onTapRegisterOrLoginButton(BuildContext context) {
    // BackGroundAnimation停止
    _animationModel.changeBackGroundAnimationState(BackGroundAnimationState.PAUSE);
    // 初回ログインのみアカウント登録可否ダイアログ表示
    if (_loginViewModel.isRegisterAccount) {
      /// アカウント作成時
      _showRegisterAccountDialog(context);
    } else {
      /// ログイン時
      //Todo: Widgetを作ってFutureBuilderでCircleIndicatorかダイアログを返すようにする
      _loginViewModel.checkMatchAccount(_nameController.text, _passController.text)
        .then((bool) {
          // 照合成功
          if (bool) {
            // 画面遷移
            Navigator.pushReplacementNamed(context, '/base');
          // 照合失敗
          } else {
            // Todo: (Debugのみ)登録情報をコンソールに表示
            debugPrint('UserName:${_loginViewModel.syncDataBaseModelInstance().getUserNameFromSync()}');
            debugPrint('UserPass:${_loginViewModel.syncDataBaseModelInstance().getUserPassFromSync()}');
          }
      });
    }
  }

  void _onTapRegisterAccountOkButton(BuildContext context) {
    // Todo: Widgetを作ってFutureBuilderでCircleIndicatorかContainerを返すようにする
    // Todo: 正常にアカウント作成できたらページ遷移、できなかったらエラーダイアログを出す
    _loginViewModel.registerAccount(_nameController.text, _passController.text)
        .then((value) {
          // 登録に失敗した時
          if (value) {
            // ダイアログ削除
            Navigator.pop(context);
            debugPrint('UserName:${_loginViewModel.syncDataBaseModelInstance().getUserNameFromSync()}');
            debugPrint('UserPass:${_loginViewModel.syncDataBaseModelInstance().getUserPassFromSync()}');
          // 登録に成功した時
          } else {
            // 登録済みであることをセット
            _loginViewModel.setIsFirstLogin(false);
            // ダイアログ削除
            Navigator.pop(context);
            // BaseViewへ画面遷移
            Navigator.pushReplacementNamed(context, '/base');
          }
        }).catchError((e) => debugPrint('アカウントを正常に登録できませんでした。(エラー内容:$e)}')
    );
  }

}