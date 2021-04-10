import 'package:flutter/material.dart';
import 'package:my_first_app/view_model/change_notifier_model.dart';
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
      // ⚠︎SizedBoxを使用する場合は、HomeIndicatorの高さを考慮する
      height: DimensManager.dimensHomeSize.bottomNavigationBarHeight,
//      height: 0,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: _settingViewModel.isDarkMode ? Colors.grey : Colors.blueGrey.withOpacity(0.7),
        ),
        child: Selector<BaseViewModel,DataBaseState>(
          selector: (context, model) => model.getState,
          shouldRebuild: (oldState, newState) => oldState != newState,
          builder: (context, state,__) {
            //通信中はクリックガードする
            return IgnorePointer(
              ignoring: state == DataBaseState.STOP ? false : true,
              child: BottomNavigationBar(
                elevation: 0.0,
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