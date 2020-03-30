import 'package:flutter/material.dart';
import 'function/inheritedwidget.dart';
import 'function/stop_activity.dart';
import 'function/inherited.dart';
import 'function/provider_simple.dart';
import 'function/color_theme.dart';
import 'function/future_stream_builder.dart';
import 'function/dialog.dart';

class FunctionTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('功能性组件'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text('导航返回拦截'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return StopActivityTest();
              }));
            },
          ),
          FlatButton(
            child: Text('Increment-自增'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return InheritedWidgetTestRoute();
              }));
            },
          ),  FlatButton(
            child: Text('InheritedWidget-数据共享'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return InheritedWidgetRoute();
              }));
            },
          ),
          FlatButton(
            child: Text('Provider-购物车'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProviderRoute();
              }));
            },
          ),
          FlatButton(
            child: Text('颜色和主题'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AppBarTest();
              }));
            },
          ),
          FlatButton(
            child: Text('异步UI更新-FutureBuilder'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AsyncUpdateUiTest();
              }));
            },
          ),
          FlatButton(
            child: Text('异步UI更新-StreamBuilder'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AsyncUpdateUiTest2();
              }));
            },
          ),
          FlatButton(
            child: Text('对话框'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyDialog();
              }));
            },
          ),
        ],
      ),
    );
  }
}
