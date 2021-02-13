import 'package:flutter/material.dart';
import 'package:my_first_app/view_model/login_view_model.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/view/widget/background_animation.dart';
import 'package:my_first_app/view_model/setting_view_model.dart';
import 'package:my_first_app/model/animation_model.dart';

class LoginView extends StatelessWidget {

  ///Constructor
  LoginView(this._settingViewModel);

  ///Variable
  final LoginViewModel _loginViewModel = LoginViewModel();
  final SettingViewModel _settingViewModel;
  final AnimationModel _animationModel = AnimationModel();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _loginViewModel.checkDoneAll();
    debugPrint('loginViewBuild');
    return ChangeNotifierProvider(
      create: (_) => _animationModel,
      child: ChangeNotifierProvider(
        create: (_) => _loginViewModel,
        child: Scaffold(
          body: Stack(
            children: <Widget>[

              // Background Animation
              Consumer<AnimationModel>(
                builder: (_,model,__) {
                  if (_animationModel.getAnimationState) {
                    return Container();
                  } else {
                    return BackGroundAnimation(model);
                  }
                },
              ),

              Padding(
                padding: EdgeInsets.only(left: 50.0, right: 50.0),
                child: Center(
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
                      Selector<LoginViewModel, bool>(
                        selector: (_, loginViewModel) => loginViewModel.isDoneAll,
                        builder: (context, isDoneAll, _) {
                          if (isDoneAll) {
                            // Todo: リリース時は使用しないこと
                            return _debugBuildLoginButtonWithDeleteAccount(context, true);
                          } else {
                            return Container();
                          }
                        },
                      ),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserAvatarImage() {
    return CircleAvatar(
      backgroundImage: null,
      child: _loginViewModel.isSetImage
          ? null
          : Text(
        'User Image',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      minRadius: 60.0,
      maxRadius: 100.0,
      backgroundColor: Colors.grey,
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
        if (value.isEmpty) {
          _loginViewModel.changeIsDoneName(false);
          return '⚠︎Please enter your name';
        }
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
        //Info: キーボードを閉じる
        FocusScope.of(context).unfocus();
      },
      onChanged: (String pass) {
        _loginViewModel.setUserPass(_passController.text);
        _loginViewModel.checkDoneAll();
      },
    );
  }

  // Todo: リリース時は使用しないこと
  Widget _debugBuildLoginButtonWithDeleteAccount(BuildContext context, bool isIndicateDeleteButton) {
    if (isIndicateDeleteButton) {
      return Column(
        children: [
          _buildLoginButton(context),
          RaisedButton(
            child: Text('Delete Account'),
            textColor: Colors.black,
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            //ボタンの影
            elevation: 10.0,
            //タップ時エフェクト
            splashColor: Colors.white,
            onPressed: () {
              // 登録アカウントを削除
              _loginViewModel.deleteAccount()
                  .then((bool) {
                    // 登録済み情報をリセット
                    _loginViewModel.setIsFirstLogin(true);
                    // 登録用フィールドをクリア
                    _nameController.clear();
                    _passController.clear();
              });
            },
          ),
        ],
      );
    } else {
      return _buildLoginButton(context);
    }
  }

  Widget _buildLoginButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.0),  //Todo: Stackで絶対位置指定に変更予定
      child: RaisedButton(
        child: Selector<LoginViewModel, bool>(
          selector: (_, loginViewModel) => loginViewModel.isRegisterAccount,
          builder: (context, isFirstLogin, _) {
            if (isFirstLogin) {
              return Text('Create');
            } else {
              return Text('Login');
            }
          }
        ),
        textColor: Colors.black,
        color: Colors.grey,
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
                  _animationModel.stopAnimation(false);
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
    _animationModel.stopAnimation(true);
    // 初回ログインのみアカウント登録可否ダイアログ表示
    if (_loginViewModel.isRegisterAccount) {
      /// アカウント作成時
      _showRegisterAccountDialog(context);
    } else {
      /// ログイン時
      //Todo: Widgetを作ってFutureBuilderでCircleIndicatorかダイアログを返すようにする
      _loginViewModel.checkMatchAccount(_nameController.text, _passController.text)
          .then((bool) {
            if (bool) Navigator.of(context).pushReplacementNamed('/base');
//            if (!bool) ;
      });
    }
  }

  void _onTapRegisterAccountOkButton(BuildContext context) {
    // Todo: Widgetを作ってFutureBuilderでCircleIndicatorかContainerを返すようにする
    // Todo: 正常にアカウント作成できたらページ遷移、できなかったらエラーダイアログを出す
    _loginViewModel.registerAccount(_nameController.text, _passController.text)
        .then((value) {
          // 登録済みであることをセット
          _loginViewModel.setIsFirstLogin(false);
          // 画面遷移
          Navigator.of(context).pushReplacementNamed('/base');
    })
        .catchError((e) => debugPrint('アカウントを正常に登録できませんでした。(エラー内容:$e)}')
    );
  }

}