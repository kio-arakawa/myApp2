import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:my_first_app/state/state_manager.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:my_first_app/my_enum/data_base_state.dart';

class BottomNavigationBarItems extends HookWidget {

  ///Constructor
  BottomNavigationBarItems();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Info: SizedBoxを使用する場合は、HomeIndicatorの高さを考慮する
      height: DimensManager.dimensHomeSize.bottomNavigationBarHeight,
      child: Consumer(
        builder: (context, watch, _) {
          final appThemeModel = watch(appThemeModelProvider);
          return Theme(
            data: Theme.of(context).copyWith(
              canvasColor: appThemeModel.isAppThemeDarkNow()
                  ? Colors.grey
                  : Colors.blueGrey.withOpacity(0.7),
            ),
            child: Consumer(
              builder: (context, watch, _) {
                final baseViewModel = watch(baseViewModelProvider);
                //通信中はクリックガードする
                return IgnorePointer(
                  ignoring: baseViewModel.getState == DataBaseState.STOP ? false : true,
                  child: BottomNavigationBar(
                    elevation: 0.0,
                    items: const <BottomNavigationBarItem> [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
//                  backgroundColor: Colors.white,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.edit),
                        label: 'Diary',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.import_contacts),
                        label: 'History',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: 'Setting',
                      ),
                    ],
                    currentIndex: baseViewModel.selectedIndex,
                    onTap: baseViewModel.onItemTapped,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

}