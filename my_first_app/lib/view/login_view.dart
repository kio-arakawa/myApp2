import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/widget/background_animation.dart';
import 'package:my_first_app/view_model/setting_view_model.dart';
import 'package:my_first_app/model/user_info.dart';
import 'package:my_first_app/model/animation_model.dart';

class LoginView extends StatelessWidget {

  ///Constructor
  LoginView(this._settingViewModel, this._userInfo);

  ///Variable
  SettingViewModel _settingViewModel;
  UserInfo _userInfo;
  AnimationModel _animationModel = AnimationModel();
  //初回登録かどうかのフラグ
  bool isFirstLogin = true;
  //プロフィール画像設定フラグ
  bool isSetImage = false;
  //ユーザー名入力完了フラグ
  bool isDoneName = false;
  //パスワード入力完了フラグ
  bool isDonePass = false;
  //必須設定項目完了フラグ
  bool isDoneAll = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _animationModel,
      child: Scaffold(
        body: Stack(
          children: <Widget>[

            //Background Animation
            Consumer<AnimationModel>(
              builder: (_,model,__) {
                if (_animationModel.isAnimationStop) {
                  return Container();
                } else {
                  return BackGroundAnimation(model);
                }
              },
            ),

            Opacity(
              opacity: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 50.0, right: 50.0),
                child: Center(
                  child: Column(
                    //中央揃え
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      //プロフィール画像登録用フィールド
//              if (isFirstLogin)
                      CircleAvatar(
                        backgroundImage: null,
                        child: isSetImage
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
                      ),

                      //ユーザー名入力用フィールド
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'User Name',
                          hintText: 'Enter your name.',
                        ),
                        //入力文字数制限
                        maxLength: 30,
                        //text自動チェック
                        autovalidate: true,
                        //text値変更時コールバック
                        validator: (value) {
                          if (value.isEmpty) {
                            return '⚠︎Please enter your name';
                          }
                          return null;
                        },
                      ),

                      //パスワード入力用フィールド
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'User Password',
                          hintText: 'Enter your password.',
                        ),
                        //入力文字数制限,
                        maxLength: 30,
                        //text自動チェック
                        autovalidate: true,
                        //text値変更時コールバック
                        validator: (value) {
                          if (value.isEmpty) {
                            isDonePass = false;
                            return '⚠︎Please enter your password';
                            //パスワード入力数６文字以上制限
                          } else if (value.length < 6) {
                            isDonePass = false;
                            return '⚠︎Please enter at least 8 characters';
                          }
                          isDonePass = true;
                          return null;
                        },
                      ),

                      //登録完了用ボタン
//              if (isDoneAll)
                      Padding(
                        padding: EdgeInsets.only(top: 50.0),  //Todo: Stackで絶対位置指定に変更予定
                        child: RaisedButton(
                          child: isFirstLogin ? Text('Create') : Text('Login'),
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
                            _animationModel.stopAnimation(true);
                            //初回ログインのみダイアログ表示
                            if (isFirstLogin) {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: Center(child: Text('Register User')),
                                      content: Text('Are you sure you want to finish user registration?'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Back'),
                                          onPressed: () {
                                            _animationModel.stopAnimation(false);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('Go!'),
                                          onPressed: () {
                                            //Todo: Widgetを作ってFutureBuilderでCircleIndicatorかContainerを返すようにする
                                            //Todo: 正常にアカウント作成できたらページ遷移、できなかったらエラーダイアログを出す
                                            Navigator.of(context).pushReplacementNamed('/base');
                                          },
                                        ),
                                      ],
                                    );
                                  }
                              );
                            } else {
                              ///ログイン時
                              Container();
                              //Todo: Widgetを作ってFutureBuilderでCircleIndicatorかダイアログを返すようにする
                              Navigator.of(context).pushReplacementNamed('/base');
                            }
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}