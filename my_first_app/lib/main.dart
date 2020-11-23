import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/view/login_view.dart';
import 'package:my_first_app/view/base_view.dart';
import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/view_model/diary_view_model.dart';
import 'package:my_first_app/view_model/home_view_model.dart';
import 'package:my_first_app/view_model/setting_view_model.dart';
import 'package:my_first_app/model/user_info.dart';
import 'package:my_first_app/model/data_base_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BaseViewModel()),
        ChangeNotifierProvider(create: (context) => SettingViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => ChatViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  ///Variable
  //ユーザー情報のリポジトリmodel
  UserInfo _userInfoModel;

  @override
  Widget build(BuildContext context) {
    ///Create UserInfo Repository
    _userInfoModel = UserInfo();
    return Provider<DataBaseModel>(
      create: (context) => DataBaseModel(),
      dispose: (context, databaseModel) => databaseModel.dispose(),
      child: Consumer<SettingViewModel>(
        builder: (_,model,__) {
          return MaterialApp(
            title: 'MyApp',
            theme: model.buildTheme(),
            routes: <String, WidgetBuilder> {
              '/': (BuildContext context) => new LoginView(model, _userInfoModel),
              '/base': (BuildContext context) => new BaseView(model, _userInfoModel),
            },
          );
        },
      ),
    );
  }

}