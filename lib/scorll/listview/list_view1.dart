import 'package:flutter/material.dart';

//无下划线的ListView
class MyListView1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('无下划线的ListView'),
      ),
      body: ListView.builder(
        itemCount: 50, //item数量
//        itemExtent: 45.0, //强制高度
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: index % 5 == 0
              ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('2020-03-${index~/2}',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600)),
                      Container(margin: EdgeInsets.only(bottom: 10.0),),
                      Text('$index')
                    ],
                  ),
                )
              : Text('$index'),
        ),
      ),
    );
  }
}
