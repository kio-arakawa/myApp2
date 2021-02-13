import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/view_model/setting_view_model.dart';

class SettingView extends StatelessWidget {

  ///Constructor
  SettingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('settingViewBuild');
    //横画面の時用にSafeAreaでラップ
    return SafeArea(
      child: Container(
        height: 900,
        child: SingleChildScrollView(
          child: Consumer<SettingViewModel>(
            builder: (_,model,__) {
              return Column(
                children: <Widget>[

                  _createSectionContainer(
                    section: _createSectionTitle(
                      model: model,
                      title: 'Developer Options',
                    ),
                    tiles: [
                      _createListTile(
                        model: model,
                        isSwitchListTile: true,
                        icon: Icon(
                          Icons.lightbulb_outline,
                          color: model.isDarkMode ? Colors.yellow : Colors.black,
                        ),
                        text: 'Dark Mode',
                        value: model.isDarkMode,
                        function: (bool value) => model.changeDarkMode(value),
                      ),

                      _createListTile(
                        model: model,
                        isSwitchListTile: true,
                        icon: Icon(
                          Icons.bug_report,
                          color: model.isDebugMode ? Colors.green : Colors.black,
                        ),
                        text: 'Debug Mode',
                        value: model.isDebugMode,
                        function: (bool value) => model.changeDebugMode(value),
                      ),
                    ],
                  ),

                  _createSectionContainer(
                    section: _createSectionTitle(
                      model: model,
                      title: 'User Setting',
                    ),
                    tiles: [

                      _createListTile(
                        model: model,
                        isSwitchListTile: false,
                        icon: Icon(
                          Icons.assignment_ind,
                          color: model.isDarkMode ? Colors.black : Colors.black,
                        ),
                        text: 'Setting Profile',
                        function: null,
                      ),

                      _createListTile(
                        model: model,
                        isSwitchListTile: false,
                        icon: Icon(
                          Icons.autorenew,
                          color: model.isDarkMode ? Colors.black : Colors.black,
                        ),
                        text: 'Diary Information Initialization',
                        function: null,
                      ),

                    ],
                  ),

                  _createSectionContainer(
                    section: _createSectionTitle(
                      model: model,
                      title: 'Other',
                    ),
                    tiles: [
                      _createListTile(
                        model: model,
                        isSwitchListTile: false,
                        icon: Icon(
                          Icons.help,
                          color: model.isDarkMode ? Colors.black : Colors.black,
                        ),
                        text: 'Help',
                        function: null,
                      ),
                    ]
                  ),

                ],
              );
            },
          ),
        ),
      ),
    );
  }

  ///Sectionごとのまとまりを生成
  Widget _createSectionContainer({Widget section, List<Widget> tiles}) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        left: 2.0,
        right: 2.0,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1.0,
            blurRadius: 10.0,
            offset: Offset(10, 10),
          ),
        ],
      ),
      child: Card(
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            section,
            Column(
              children: tiles,
            ),
          ],
        ),
      ),
    );
  }

  ///SectionTitleを生成
  Widget _createSectionTitle({SettingViewModel model,String title}) {
    return Container(
        margin: EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        width: 400,
        child: Text(
          title,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: model.isDarkMode ? Colors.black : Colors.black,
//          decoration: TextDecoration.underline,
//          decorationStyle: TextDecorationStyle.dotted,
          ),
        )
    );
  }

  ///NormalListTileまたはSwitchListTileを生成
  Widget _createListTile({
    SettingViewModel model,
    bool isSwitchListTile,
    Icon icon,
    Icon subIcon,
    String text,
    bool value,
    Function function,
  }) {
    if (isSwitchListTile) {
      ///Create SwitchListTile
      return Container(
        height: 64,
        margin: EdgeInsets.only(
          left: 4.0,
          right: 4.0,
        ),
        child: Card(
          color: Colors.white70,
          child: SwitchListTile(
            secondary: FittedBox(child: icon),
            activeColor: Colors.orange,
            activeTrackColor: Colors.grey,
            inactiveTrackColor: Colors.grey,
            value: value,
            title: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: model.isDarkMode ? Colors.black : Colors.black,
                fontSize: 18,
              ),
            ),
            onChanged: function,
          ),
        ),
      );
    } else {
      ///Create NormalListTile
      return Container(
        height: 64,
        margin: EdgeInsets.only(
          left: 4.0,
          right: 4.0,
        ),
        child: Card(
          color: Colors.white70,
          child: ListTile(
            leading: FittedBox(child: icon),
            trailing: FittedBox(
              child: Icon(
                Icons.chevron_right,
                color: model.isDarkMode ? Colors.black : Colors.black,
            ),
            ),
            title: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: model.isDarkMode ? Colors.black : Colors.black,
                fontSize: 18,
              ),
            ),
            onTap: function,
          ),
        ),
      );
    }
  }

}