import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:my_first_app/state/state_manager.dart';
import 'package:my_first_app/view_model/init_setting_and_tutorial_view_model.dart';

class InitSettingAndTutorialView extends HookWidget {

  /// Build Method
  @override
  Widget build(BuildContext context) {
    final initSettingAndTutorialViewModel = useProvider(initSettingAndTutorialViewModelProvider);
    return Container(
      height: DimensManager.dimensBaseSize.fullHeight,
      width: DimensManager.dimensBaseSize.fullWidth,
      child: Stack(
        children: [
          // BackGroundColor
          Container(
            color: Colors.black.withOpacity(0.85),
          ),
          // Tutorial
          if(!initSettingAndTutorialViewModel.isDrawSettingUserNamePage)
          _buildTutorialPage(initSettingAndTutorialViewModel),
          // SettingUserName
          if(initSettingAndTutorialViewModel.isDrawSettingUserNamePage)
          _buildSettingUserNamePage(initSettingAndTutorialViewModel),
        ],
      ),
    );
  }

  /// [Begin] Build SettingUserNamePage
  Widget _buildSettingUserNamePage(InitSettingAndTutorialViewModel initSettingAndTutorialViewModel) {
    return Column(
      children: [
        // Body
        _buildSettingUserNameBody(initSettingAndTutorialViewModel),
        // Button
        if (initSettingAndTutorialViewModel.isFinishSettingUserName)
        _buildSettingUserNamePageButton(initSettingAndTutorialViewModel),
      ],
    );
  }

  Widget _buildSettingUserNameBody(InitSettingAndTutorialViewModel initSettingAndTutorialViewModel) {
    return Container(
      height: DimensManager.dimensBaseSize.tutorialPageBodyHeight,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Text(
                    'ユーザー名を設定',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    maxLines: 1,
                    maxLength: 20,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    onChanged: (text) => initSettingAndTutorialViewModel.checkInputUserName(text),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Text(
                    '※後からでも変更できます。',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingUserNamePageButton(InitSettingAndTutorialViewModel initSettingAndTutorialViewModel) {
    return Container(
      height: DimensManager.dimensBaseSize.tutorialPageButtonHeight,
      alignment: Alignment.topCenter,
      child: Container(
        // HomeIndicator対応
        padding: EdgeInsets.only(
          bottom: DimensManager.dimensBaseSize.homeIndicatorHeight,
        ),
        alignment: Alignment.center,
        child: ElevatedButton(
          child: const Text('決定する'),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue.withOpacity(0.3),
            onPrimary: Colors.white,
            textStyle: TextStyle(
              fontSize: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            initSettingAndTutorialViewModel.changeIsDrawSettingUserNamePageFlag();
          },
        ),
      ),
    );
  }
  /// [End] Build SettingUserNamePage

  /// [Begin] Build TutorialPage
  Widget _buildTutorialPage(InitSettingAndTutorialViewModel initSettingAndTutorialViewModel) {
    return Column(
      children: [
        // Body
        _buildTutorialPageBody(),
        // Button
        _buildTutorialButton(initSettingAndTutorialViewModel),
      ],
    );
  }

  Widget _buildTutorialPageBody() {
    return Container(
      height: DimensManager.dimensBaseSize.tutorialPageBodyHeight,
      alignment: Alignment.center,
      child: Container(
//        color: Colors.grey,
      ),
    );
  }

  Widget _buildTutorialButton(InitSettingAndTutorialViewModel initSettingAndTutorialViewModel) {
    final baseViewModel = useProvider(baseViewModelProvider);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
      ),
      height: DimensManager.dimensBaseSize.tutorialPageButtonHeight,
      alignment: Alignment.topCenter,
      child: Container(
        // HomeIndicator対応
        padding: EdgeInsets.only(
          bottom: DimensManager.dimensBaseSize.homeIndicatorHeight,
        ),
        alignment: Alignment.center,
        // Info: InkWellには自分より親階層に、MaterialWidgetが必要(ScaffoldなどもMaterial)
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => {
              baseViewModel.onTapCloseTutorialButton(),
            },
            child: FittedBox(
              child: Text(
                '閉じる',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  /// [End] Build TutorialPage

}