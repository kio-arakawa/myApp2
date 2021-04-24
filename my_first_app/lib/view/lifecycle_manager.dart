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
  final LifecycleCallback callback;
  final BuildContext context;
  final VoidCallback osLightThemeCallBack;
  final VoidCallback osDarkThemeCallBack;

  LifecycleManager({
    Key key,
    this.child,
    this.callback,
    this.context,
    this.osLightThemeCallBack,
    this.osDarkThemeCallBack,
  }) : super(key: key);

  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifecycleManager>
    with WidgetsBindingObserver {

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
        widget.callback?.onResumed(
            context,
            widget.osLightThemeCallBack,
            widget.osDarkThemeCallBack,
        );
        break;
      case AppLifecycleState.inactive:
        widget.callback?.onInactive();
        break;
      case AppLifecycleState.paused:
        widget.callback?.onPaused();
        break;
      case AppLifecycleState.detached:
        widget.callback?.onDetached();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }

}