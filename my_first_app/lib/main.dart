import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/view/base_view.dart';
import 'package:my_first_app/view_model/setting_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingModel(),
      child: Consumer<SettingModel>(
        builder: (_,model,__) {
          return MaterialApp(
            title: 'MyApp',
            theme: model.buildTheme(),
            home: BaseView(model),
          );
        },
      ),
    );
  }

}