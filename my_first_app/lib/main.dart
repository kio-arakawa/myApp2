import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/view/login_view.dart';
import 'package:my_first_app/view/base_view.dart';
import 'package:my_first_app/view_model/setting_view_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingViewModel(),
      child: Consumer<SettingViewModel>(
        builder: (_,model,__) {
          return MaterialApp(
            title: 'MyApp',
            theme: model.buildTheme(),
            routes: <String, WidgetBuilder> {
              '/': (BuildContext context) => new LoginView(model),
              '/base': (BuildContext context) => new BaseView(model),
            },
          );
        },
      ),
    );
  }

}