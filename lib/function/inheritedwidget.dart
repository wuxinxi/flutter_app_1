import 'package:flutter/material.dart';

class InheritedWidgetRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InheritedWidgetRouteState();
}

class InheritedWidgetRouteState extends State<InheritedWidgetRoute> {
  bool loginState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InheritedWidget-数据共享'),
      ),
      body: Column(
        children: <Widget>[
          MyInheritedWidget(
            loginState: loginState,
            //当loginState发生改变时 TestWidget也会改变
            child: TestWidget(),
          ),
          FlatButton(
              onPressed: () {
                setState(() => loginState = !loginState);
              },
              child: Text('点我'))
        ],
      ),
    );
  }
}

class TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TestWidgetState();
}

class TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(MyInheritedWidget.of(context).loginState ? "已登录" : "未登录");
  }
}

class MyInheritedWidget extends InheritedWidget {
  //登录状态
  final bool loginState;

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return oldWidget.loginState != loginState;
  }

  static MyInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  MyInheritedWidget({@required this.loginState, Widget child})
      : super(child: child);
}
