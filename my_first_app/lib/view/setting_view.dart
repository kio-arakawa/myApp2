import 'package:flutter/material.dart';
import 'package:my_first_app/view_model/setting_view_model.dart';
import 'package:provider/provider.dart';

class SettingView extends StatelessWidget {

  ///Constructor
  SettingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 64,
          child: Card(
            child: Column(
              //Columnの中央揃え
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Consumer<SettingViewModel>(
                  builder: (_,model,__) {
                    return SwitchListTile(
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}