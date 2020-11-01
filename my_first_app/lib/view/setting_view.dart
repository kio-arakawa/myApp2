import 'package:flutter/material.dart';
import 'package:my_first_app/view_model/setting_view_model.dart';
import 'package:provider/provider.dart';

class SettingView extends StatelessWidget {

  ///Constructor
  SettingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingViewModel>(
      builder: (_,model,__) {
        return Column(
          children: <Widget>[

            ///ここ以下にSwitchListTileを追加していく
            _createSwitchListTile(
              SwitchListTile(
                secondary: Icon(
                  Icons.lightbulb_outline,
                  color: model.isDarkMode ? Colors.yellow : Colors.black,
                ),
                activeColor: Colors.yellow,
                activeTrackColor: Colors.grey,
                inactiveTrackColor: Colors.grey,
                value: model.isDarkMode,
                title: Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onChanged: (bool value) => model.changeDarkMode(value),
              ),
            ),

            _createSwitchListTile(
              SwitchListTile(
                secondary: Icon(
                  Icons.android,
                  color: model.isDarkMode ? Colors.yellow : Colors.black,
                ),
                activeColor: Colors.yellow,
                activeTrackColor: Colors.grey,
                inactiveTrackColor: Colors.grey,
                value: model.isDebugMode,
                title: Text(
                  'Debug Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onChanged: (bool value) => model.changeDebugMode(value),
              ),
            ),

          ],
        );
      },
    );
  }

  /// SwitchListTileを引数にCardを生成する
  Widget _createSwitchListTile(SwitchListTile widget) {
    return Container(
      height: 64,
      child: Card(
        child: widget,
      ),
    );
  }

}