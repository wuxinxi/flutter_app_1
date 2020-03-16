import 'package:flutter/material.dart';

class NotificationTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationState();
}

class NotificationState extends State<NotificationTestRoute> {
  String state = '初始';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('滚动监听'),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(right: 50.0),
                child: Text(state),
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: NotificationListener(
                  onNotification: (notification) {
                    switch (notification.runtimeType) {
                      case ScrollStartNotification:
                        print('开始滚动');
                        setState(() => state = '开始滚动');
                        break;
                      case ScrollUpdateNotification:
                        print('正在滚动');
                        setState(() => state = '正在滚动');
                        break;
                      case ScrollEndNotification:
                        print('停止了滚动');
                        setState(() => state = '停止了滚动');
                        break;
                      case OverscrollNotification:
                        print('滚动到了边界');
                        setState(() => state = '滚动到了边界');
                        break;
                    }
                    return true;
                  },
                  child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text('$index'));
                      })),
            ),
            NotificationTest(),
          ],
        ));
  }
}

class NotificationTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationTestState();
}

class NotificationTestState extends State<NotificationTest> {
  String msg = 'defalut';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(msg),
        NotificationListener<MyNotification>(onNotification: (notification) {
          setState(() => msg = notification.msg);
          return true;
        }, child: Builder(builder: (context) {
          return RaisedButton(
            child: Text("点我"),
            onPressed: () {
              //因为NotificationListener监听的是子树，所以context不能用根context，用Builder来构建RaisedButton
              MyNotification(DateTime.now().toIso8601String())
                  .dispatch(context);
            },
          );
        }))
      ],
    );
  }
}

class MyNotification extends Notification {
  final String msg;

  MyNotification(this.msg);
}
