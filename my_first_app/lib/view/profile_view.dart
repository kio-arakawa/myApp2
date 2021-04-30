import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:my_first_app/constants.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:my_first_app/state/state_manager.dart';

class ProfileView extends HookWidget {

  ProfileView._();
  static ProfileView _instance;
  factory ProfileView() {
    print('ProfileView Build!');
    return _instance ??= ProfileView._();
  }

  void _initializer(BuildContext context) {
    DimensManager.dimensProfileViewSize.initialDimens<ProfileView>(context);
  }

  @override
  Widget build(BuildContext context) {
    // 初期処理
    _initializer(context);
    // Info: Heroアニメーション
    return Hero(
      tag: Constants.profileHeroAnimTag,
      child: Consumer(
        builder: (context, watch, _) {
          final profileViewModel = watch(profileViewModelProvider);
          final appThemeModel = watch(appThemeModelProvider);
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(DimensManager.dimensHomeSize.headerHeight),
              child: AppBar(
                backgroundColor: appThemeModel.isAppThemeDarkNow() ? Colors.black : Colors.white.withOpacity(0.7),
                leading: InkWell(
                  onTap: () => Navigator.pushReplacementNamed(context, '/base'),
                  child: Container(
                    color: Colors.transparent,
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.navigate_next,
                        size: 35,
                      ),
                    ),
                  ),
                ),
                centerTitle: true,
                title: Text(
                  'Profile',
                  style: TextStyle(
                    color: appThemeModel.isAppThemeDarkNow() ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            body: WillPopScope(
              onWillPop: () async => true,
              child: Container(
                height: DimensManager.dimensProfileViewSize.fullHeight,
                width: DimensManager.dimensProfileViewSize.fullWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background_image.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          /// Avatar Image
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: DimensManager.dimensProfileViewSize.displayAreaMarginTop,
                              horizontal: 0,
                            ),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/avatar_image.png',
                              ),
                              child: FittedBox(
                                child: Text(
                                  'User Image',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              minRadius: 50.0,
                              maxRadius: DimensManager.dimensProfileViewSize.avatarContainerHalfHeight,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          /// User Name
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                            ),
                            height: DimensManager.dimensProfileViewSize.avatarContainerHalfHeight,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                '${profileViewModel.syncDataBaseModelInstance().getProfileUserNameFromSync()}',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          //
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}