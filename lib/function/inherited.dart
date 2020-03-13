//InheritedWidget 它提供了一种数据在widget树中从上到下传递，共享的方式，比如我们在应用的根widget中通过InheritedWidget共享了一个数据
//那么我们可以在任意子widget中来获取该共享的数据，比如Theme/locale

import 'package:flutter/material.dart';

//计数器实例
class ShareDateWidget extends InheritedWidget {
  final int data; //需要共享的数据

  ShareDateWidget({@required this.data, Widget child}) : super(child: child);

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDateWidget of(BuildContext context) {
    //与调用者绑定依赖
//    return context.dependOnInheritedWidgetOfExactType();
    //不与调用者绑定依赖
    return context.getElementForInheritedWidgetOfExactType<ShareDateWidget>().widget;
  }

  //该回调决定当data发生改变时，是否通知子树依赖data的widget
  @override
  bool updateShouldNotify(ShareDateWidget oldWidget) {
    //返回true则子树中依赖本widget(build函数中有调用)
    //的子widget的'State.didChangeDependencies'会被调用
    print('ShareDateWidget data=$data');
    return oldWidget.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<_TestWidget> {
  //每次更新状态的时候都会被重新build，性能不行，应该被缓存起来，请看provider
  @override
  Widget build(BuildContext context) {
    return Text(ShareDateWidget.of(context).data.toString());
//    return Text('Text');
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    print('<<< didChangeDependencies change >>>');
  }
}

class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('数据共享'),
      ),
      body: Center(
        child: ShareDateWidget(
          data: count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: _TestWidget(),
              ),
              RaisedButton(
                child: Text('Increment'),
                onPressed: () => setState(() => ++count),
              )
            ],
          ),
        ),
      ),
    );
  }
}
