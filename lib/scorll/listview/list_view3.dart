import 'package:flutter/material.dart';
import 'dart:math';

//模拟下拉加载listView
class MyListView3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListViewState();
}

class ListViewState extends State<MyListView3> {
  static const loadingTag = '##loading##';
  var words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('无限加载列表'),
      ),
      body: ListView.separated(
        itemCount: words.length,
        itemBuilder: (context, index) {
          //如果到了底部
          if (words[index] == loadingTag) {
            //如果数据不足100条，继续获取数据
            if (words.length - 1 < 100) {
              loadData();
              return Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0)),
              );
            } else {
              return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),
                  child: Text('没有更多了',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey)));
            }
          }
          return ListTile(
            title: Text(words[index]),
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 1.0,
        ),
      ),
    );
  }

  void loadData() {
    Future.delayed(Duration(seconds: 3)).then((result) {
      setState(() {
        words.insertAll(words.length - 1, getRandomList());
      });

    });

  }

  getRandomList() {
    List<String> list = List();
    for (int i = 0; i < 20; i++) {
      list.add(Random().nextInt(10000).toString() + "$i");
    }
    return list;
  }
}
