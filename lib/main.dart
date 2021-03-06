import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '10_custom_widget.dart';
import '11_io.dart';
import '12_plugin.dart';
import '13_simple.dart';
import '8_listener.dart';
import '2_base_widget.dart';
import '4_layout.dart';
import '5_box.dart';
import '6_scroll.dart';
import '7_function.dart';
import '9_animator.dart';
import 'i10n/localization_intl.dart';
import 'localizations/localizations.dart';
import 'util/utils.dart';
import 'util/event_bus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyMaterialApp(MyHomePage(title: 'Flutter Demo Home Page'));
  }
}

class MyMaterialApp extends StatefulWidget {
  final Widget home;

  MyMaterialApp(this.home);

  @override
  State<StatefulWidget> createState() => MyMaterialAppState(home);
}

class MyMaterialAppState extends State<MyMaterialApp> {
  Color themeColor = getRandomMaterialColor();
  Widget home;

  @override
  void initState() {
    super.initState();
    bus.on('change',
        (arg) => setState(() => themeColor = getRandomMaterialColor()));
  }

  @override
  void dispose() {
    super.dispose();
    bus.off('change');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //多语言
      localizationsDelegates: [
        //本地化代理
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        //注册我们的代理
        MyLocalizationsDelegate(),
      ],
      supportedLocales: [
        //美国英语
        const Locale('en', 'US'),
        //中文简体
        const Locale('zh', 'CN')
      ],
      //监听语言切换事件
      localeResolutionCallback: (locale, supportedLocales) {
        print('当前：${locale.languageCode}');
        print(supportedLocales);
        if (supportedLocales.contains(locale.languageCode)) {
          print('包含');
          return locale;
        }
        return Locale('zh', 'CN');
      },
      onGenerateTitle: (context) => MyLocalizations.of(context).appTitle,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: themeColor,
      ),
      home: home,
    );
  }

  MyMaterialAppState(this.home);
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
              child: Text(MyLocalizations.of(context).baseWidgetExampleText),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BaseWidget();
                }));
              },
            ),
            FlatButton(
              child: Text(MyLocalizations.of(context).layoutWidgetExampleText),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Layout();
                }));
              },
            ),
            FlatButton(
              child: Text('容器类组件示例'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Box();
                }));
              },
            ),
            FlatButton(
              child: Text('可滚动组件示例'),
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
            FlatButton(
              child: Text('事件'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DragText();
                }));
              },
            ),
            FlatButton(
              child: Text('动画'),
              onPressed: () {
                //MaterialPageRoute android 默认路由动画
                //CupertinoPageRoute IOS路由动画

                //自定义
//                Navigator.push(context, PageRouteBuilder(pageBuilder: (context,animation,secondaryAnimation){
//                  return FadeTransition(opacity: animation,child: ScaleAnimationRoute(),);
//                }));

                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return ScaleAnimationRoute();
                }));
              },
            ),
            FlatButton(
              child: Text('自定义Widget'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CustomWidget())),
            ),
            FlatButton(
              child: Text('IO'),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => IoRoute())),
            ),
            FlatButton(
              child: Text('插件'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BatteryLevelRoute())),
            ),
            FlatButton(
              child: Text('常用实例Demo'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SimpleDemo())),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bus.emit('change');
        },
        tooltip: '切换主题',
        child: Icon(Icons.palette),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
