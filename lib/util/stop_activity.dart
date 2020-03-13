import 'package:flutter/material.dart';
import '../util/toast.dart';

//返回拦截
class WillPopScopeRoute extends StatefulWidget {
  final Widget child;

  const WillPopScopeRoute({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => WillPopScopeRouteState(child);
}

class WillPopScopeRouteState extends State<WillPopScopeRoute> {
  DateTime lastPressTime; //上次点击时间
  final Widget _widget;

  WillPopScopeRouteState(this._widget);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: _widget,
        onWillPop: () async {
          if (lastPressTime == null ||
              DateTime.now().difference(lastPressTime) > Duration(seconds: 1)) {
            lastPressTime = DateTime.now();
            Toast.toast(context, "再按一次退出");
            return false;
          }
          return true;
        });
  }
}
