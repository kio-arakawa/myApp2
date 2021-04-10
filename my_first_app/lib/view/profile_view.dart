import 'package:flutter/material.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/model/sync_data_base_model.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {

  ProfileView._(this._syncDataBaseModel);
  static ProfileView _instance;
  factory ProfileView(SyncDataBaseModel syncDataBaseModel) {
    print('ProfileView Build!');
    return _instance ??= ProfileView._(syncDataBaseModel);
  }

  /// Variable
  final SyncDataBaseModel _syncDataBaseModel;

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
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(DimensManager.dimensHomeSize.headerHeight),
          child: AppBar(
            backgroundColor: Colors.blueGrey.withOpacity(0.7),
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
            title: Text('Profile'),
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
                            '${_syncDataBaseModel.getUserNameFromSync()}',
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
      ),
    );
  }
}