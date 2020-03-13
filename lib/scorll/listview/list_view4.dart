import 'package:flutter/material.dart';
import 'dart:math';

//模拟下拉加载listView
//滚动监听
class MyListView4 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListViewState();
}

class ListViewState extends State<MyListView4> {
  static const loadingTag = '##loading##';
  var words = <String>[loadingTag];
  ScrollController scrollController;
  bool isShowToTopBtn = false; //是否显示返回顶部按钮
  String _progress = '0'; //保存进度百分比

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(keepScrollOffset: true);
    loadData();
    scrollController.addListener(() {
      var offset = scrollController.position.maxScrollExtent;
      if (scrollController.offset < offset && isShowToTopBtn) {
        setState(() {
          isShowToTopBtn = false;
        });
      } else if (scrollController.offset >= offset && !isShowToTopBtn) {
        setState(() {
          isShowToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('无限加载列表'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 50),
            alignment: Alignment.center,
            child: Text('$_progress %', style: TextStyle(fontSize: 18.0)),
          )
        ],
      ),
      body: Scrollbar(
          child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
          setState(() {
            _progress = "${(progress * 100).toInt()}";
          });
          return false;
        },
        child: ListView.separated(
          itemCount: words.length,
          controller: scrollController,
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
      )),
      floatingActionButton: !isShowToTopBtn
          ? null
          : FloatingActionButton(
              onPressed: () {
                scrollController.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              },
              child: Icon(Icons.arrow_upward),
            ),
    );
  }

  void loadData() {
    Future.delayed(Duration(seconds: 1)).then((result) {
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
