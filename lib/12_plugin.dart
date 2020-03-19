import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryLevelRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BatteryLevelRouteState();
}

class BatteryLevelRouteState extends State<BatteryLevelRoute> {
  static const platform = const MethodChannel('samples.flutter.io/battery');
  String _batteryLevel;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('获取电量信息'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('电量信息：$_batteryLevel'),
          ),
          Container(
            height: 45.0,
            width: double.infinity,
            color: themeData.primaryColor,
            child: FlatButton(
                onPressed: () {
                  getBatteryLevel();
                },
                child: Text('获取电量信息')),
          )
        ],
      ),
    );
  }

  Future getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = 'Failed to get battery level :${e.message}';
    }
    setState(() => _batteryLevel = batteryLevel);
  }
}
