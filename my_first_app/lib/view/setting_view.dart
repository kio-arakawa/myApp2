import 'package:flutter/material.dart';
import 'package:my_first_app/view_model/setting_view_model.dart';
import 'package:provider/provider.dart';

class SettingView extends StatelessWidget {

  ///Constructor
  SettingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
      child: SingleChildScrollView(
        child: Consumer<SettingViewModel>(
          builder: (_,model,__) {
            return Column(
              children: <Widget>[

                _createSectionContainer(
                  section: _createSectionTitle('Developer Options'),
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
                        color: model.isDarkMode ? Colors.yellow : Colors.black,
                      ),
                      text: 'Debug Mode',
                      value: model.isDebugMode,
                      function: (bool value) => model.changeDebugMode(value),
                    ),
                  ],
                ),

                _createSectionContainer(
                  section: _createSectionTitle('Profile Setting'),
                  tiles: [

                    _createListTile(
                      model: model,
                      isSwitchListTile: false,
                      icon: Icon(
                        Icons.face,
                        color: model.isDarkMode ? Colors.yellow : Colors.black,
                      ),
                      subIcon: Icon(
                        Icons.chevron_right,
                        color: model.isDarkMode ? Colors.yellow : Colors.black,
                      ),
                      text: 'Setting Profile',
                      function: null,
                    ),

                  ],
                ),

              ],
            );
          },
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
  Widget _createSectionTitle(String title) {
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
            fontSize: 26,
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
            activeColor: Colors.yellow,
            activeTrackColor: Colors.grey,
            inactiveTrackColor: Colors.grey,
            value: value,
            title: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
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
            trailing: FittedBox(child: subIcon),
            title: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            onTap: function,
          ),
        ),
      );
    }
  }

}