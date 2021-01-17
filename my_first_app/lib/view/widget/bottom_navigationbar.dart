import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/my_enum/data_base_state.dart';
import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/view_model/setting_view_model.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';

class BottomNavigationBarItems extends StatelessWidget {

  ///Constructor
  BottomNavigationBarItems(this._model, this._settingViewModel);

  final BaseViewModel _model;
  final SettingViewModel _settingViewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DimensManager.dimensHomeSize.bottomNavigationBarHeight,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: _settingViewModel.isDarkMode ? Colors.black : Colors.blue,
        ),
        child: Selector<BaseViewModel,DataBaseState>(
          selector: (context, state) => _model.getState,
          builder: (_,model,__) {
            //通信中はクリックガードする
            return IgnorePointer(
              ignoring: _model.getState == DataBaseState.STOP ? false : true,
              child: Opacity(
                opacity: _model.getState == DataBaseState.STOP ? 1.0 : 0.3,
                child: BottomNavigationBar(
                  items: const <BottomNavigationBarItem> [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      title: Text('Home'),
//                  backgroundColor: Colors.white,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.edit),
                      title: Text('Diary'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.import_contacts),
                      title: Text('History'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      title: Text('Setting'),
                    ),
                  ],
                  currentIndex: _model.selectedIndex,
                  onTap: _model.onItemTapped,
                ),
              ),
            );
          },
        ),

//      child: FutureBuilder(
//        future: ,
//        child: BottomNavigationBar(
//          items: const <BottomNavigationBarItem> [
//            BottomNavigationBarItem(
//              icon: Icon(Icons.home),
//              title: Text('Home'),
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.edit),
//              title: Text('Diary'),
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.import_contacts),
//              title: Text('History'),
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.settings),
//              title: Text('Setting'),
//            ),
//          ],
//          currentIndex: _model.selectedIndex,
//          //通信中の時は画面遷移しない
//          onTap: _model.onItemTapped,
//        ),
//      ),

      ),
    );
  }

}