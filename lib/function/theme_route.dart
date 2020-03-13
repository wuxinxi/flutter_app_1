import 'package:flutter/material.dart';

//实现路由换肤
class ThemeTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ThemeTestRouteState();
}

class ThemeTestRouteState extends State<ThemeTestRoute> {
  Color themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
        data: ThemeData(
          primarySwatch: themeColor, //主题颜色样本
          iconTheme: IconThemeData(color: themeColor), //Icon的颜色
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text('主题测试'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //第一行跟随主题
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.face),
                  Container(padding: EdgeInsets.all(3.0)),
                  Icon(Icons.ac_unit),
                  Container(padding: EdgeInsets.all(3.0)),
                  Text('跟随主题颜色',
                      style: TextStyle(color: themeColor, fontSize: 18.0)),
                ],
              ),
              //第2行固定黑色
              Theme(
                //copy当前的主题并且重新赋值颜色
                data: themeData.copyWith(
                    iconTheme:
                        themeData.iconTheme.copyWith(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.face),
                    Container(padding: EdgeInsets.all(3.0)),
                    Icon(Icons.ac_unit),
                    Container(padding: EdgeInsets.all(3.0)),
                    Text('固定黑色',
                        style: TextStyle(color: Colors.black, fontSize: 18.0)),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                themeColor =
                    themeColor == Colors.teal ? Colors.blue : Colors.teal;
              });
            },
            child: Icon(Icons.palette),
          ),
        ));
  }
}
