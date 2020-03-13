import 'package:flutter/material.dart';
import 'newactivity.dart';
import '1_state_study.dart';
import '2_base_widget.dart';
import '4_layout.dart';
import '5_box.dart';
import '6_scroll.dart';
import '7_function.dart';
import 'util/utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color themeColor = getRandomMaterialColor();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: themeColor,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('基础组件实例'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BaseWidget();
                }));
              },
            ),
            FlatButton(
              child: Text('布局类组件实例'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Layout();
                }));
              },
            ),
            FlatButton(
              child: Text('容器类组件实例'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Box();
                }));
              },
            ),
            FlatButton(
              child: Text('可滚动组件实例'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Scroll();
                }));
              },
            ),
            FlatButton(
              child: Text('功能性组件实例'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FunctionTest();
                }));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: '切换主题',
        child: Icon(Icons.palette),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
