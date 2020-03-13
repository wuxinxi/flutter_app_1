import 'package:flutter/material.dart';

//无下划线的ListView
class MyListView2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(
      color: Colors.blue,
    );
    Widget divider2 = Divider(
      color: Colors.green,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('有下划线的ListView'),
      ),
      body: ListView.separated(
        itemCount: 50, //item数量
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Container(
            alignment: Alignment.center,
            child: Text('$index'),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? divider1 : divider2;
        },
      ),
    );
  }
}
