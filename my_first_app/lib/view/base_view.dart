import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/view/home_view.dart';
import 'package:my_first_app/view/setting_view.dart';
import 'package:my_first_app/view/chat_view.dart';
import 'package:my_first_app/view/history_view.dart';
import 'package:my_first_app/widget/bottom_navigationbar.dart';
import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/view_model/setting_model.dart';

class BaseView extends StatelessWidget {

  ///Constructor
  BaseView(this._settingModel);

  BaseViewModel _model = BaseViewModel();

  SettingModel _settingModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _model,
      child: Consumer<BaseViewModel>(
        builder: (_,model,__) {
          return Scaffold(
            appBar: AppBar(
              title: Text(model.appBarTitle),
            ),

            body:SafeArea(child: _pageList[model.selectedIndex]),

            bottomNavigationBar: BottomNavigationBarItems(model, _settingModel),
          );
        },
      ),
    );
  }

  static List<Widget> _pageList = [
    HomeView(),
    ChatView(),
    HistoryView(),
    SettingView(),
  ];

}
