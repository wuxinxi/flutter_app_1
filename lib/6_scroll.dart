import 'package:flutter/material.dart';
import 'package:flutter_app_1/scorll/scrollview/MySingleChildScrollView.dart';
import 'package:flutter_app_1/scorll/listview/list_view1.dart';
import 'package:flutter_app_1/scorll/listview/list_view2.dart';
import 'package:flutter_app_1/scorll/listview/list_view3.dart';
import 'package:flutter_app_1/scorll/listview/list_view4.dart';
import 'package:flutter_app_1/scorll/gridview/grid_view1.dart';
import 'package:flutter_app_1/scorll/custom/custom_scroll_view.dart';
import 'package:flutter_app_1/scorll/custom/custom_scroll_view2.dart';
import 'package:flutter_app_1/util/stop_activity.dart';

class Scroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('可滚动组件'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                child: Text('SingleChildScrollView',
                    style: TextStyle(fontSize: 18.0)),
                onPressed: () {
                  startActivity(context, MySingleChildScrollView());
                },
              ),
              FlatButton(
                child: Text('ListView-1', style: TextStyle(fontSize: 18.0)),
                onPressed: () {
                  startActivity(context, MyListView1());
                },
              ),
              FlatButton(
                child: Text('ListView-2-分隔符', style: TextStyle(fontSize: 18.0)),
                onPressed: () {
                  startActivity(context, MyListView2());
                },
              ),
              FlatButton(
                child: Text('ListView-3-无限加载', style: TextStyle(fontSize: 18.0)),
                onPressed: () {
                  startActivity(context, MyListView3());
                },
              ),
              FlatButton(
                child: Text('ListView-4-监听', style: TextStyle(fontSize: 18.0)),
                onPressed: () {
                  startActivity(context, MyListView4());
                },
              ),
              FlatButton(
                child: Text('GridView', style: TextStyle(fontSize: 18.0)),
                onPressed: () {
                  startActivity(context, MyGridView());
                },
              ),
              FlatButton(
                child: Text('CustomScrollView:ListView+GridView',
                    style: TextStyle(fontSize: 18.0)),
                onPressed: () {
                  startActivity(context, AddScrollView());
                },
              ),
              FlatButton(
                child:
                    Text('CustomScrollView', style: TextStyle(fontSize: 18.0)),
                onPressed: () {
                  startActivity(context, AddScrollView2());
                },
              )
            ],
          ),
        ));
  }

  void startActivity(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}
