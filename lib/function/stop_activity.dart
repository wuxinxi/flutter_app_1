import 'package:flutter/material.dart';
import '../util/stop_activity.dart';

class StopActivityTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('双击返回'),
        ),
        body: WillPopScopeRoute(
          child: Center(child: Text('双击返回')),
        ));
  }
}
