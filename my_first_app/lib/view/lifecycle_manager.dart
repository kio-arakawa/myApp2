import 'package:flutter/material.dart';

/// ライフサイクルコールバックインターフェース
class LifecycleCallback {
  // FGに復帰完了
  void onResumed(
      BuildContext context,
      VoidCallback osLightThemeCallBack,
      VoidCallback osDarkThemeCallBack
      )
  {
    // Info: Buildメソッド完了後にCallする。
    //       didChangeAppLifecycleStateメソッド内でCallすると古いcontextでBrightnessを取得してしまう。
    final Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);
    // OSのテーマカラーがライトモード
    if (platformBrightness == Brightness.light) {
      osLightThemeCallBack.call();
    // OSのテーマカラーがダークモード
    } else {
      osDarkThemeCallBack.call();
    }
    debugPrint('OsTheme:$platformBrightness');
  }

  // BGに移動完了
  void onPaused() {}

  // FGとBGの移動中
  void onInactive() {}

  void onDetached() {}
}

/// ライフサイクルを受け取れるStatefulWidget
class LifecycleManager extends StatefulWidget {

  final Widget child;
  final LifecycleCallback callback = LifecycleCallback();
  final BuildContext context;
  final VoidCallback osLightThemeCallBack;
  final VoidCallback osDarkThemeCallBack;

  LifecycleManager({
    Key key,
    this.child,
    this.context,
    this.osLightThemeCallBack,
    this.osDarkThemeCallBack,
  }) : super(key: key);

  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifecycleManager>
    with WidgetsBindingObserver {

  bool _isNeedCheck = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('state = $state');
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        widget.callback?.onInactive();
        _isNeedCheck = true;
        break;
      case AppLifecycleState.paused:
        widget.callback?.onPaused();
        _isNeedCheck = true;
        break;
      case AppLifecycleState.detached:
        widget.callback?.onDetached();
        break;
    }
  }

  void _onBuildComplete() {
    if(_isNeedCheck) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.callback?.onResumed(
          context,
          widget.osLightThemeCallBack,
          widget.osDarkThemeCallBack,
        );
        _isNeedCheck = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
//    _onBuildComplete();
    return Container(
      child: widget.child,
    );
  }

}