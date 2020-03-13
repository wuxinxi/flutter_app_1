import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class AsyncUpdateUiTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('异步UI更新')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                FutureBuilder<String>(
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print(snapshot.data);
                      return Text(snapshot.hasError
                          ? '加载失败[${snapshot.error}]'
                          : '加载成功[${snapshot.data}]');
                    }
                    return CircularProgressIndicator();
                  },
                  future: _get(),
                )
              ],
            ),
          ),
        ));
  }

  Future<String> _get() async {
    var data = '加载失败';
    var url = 'https://wanandroid.com/wxarticle/chapters/json';
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      data = await response.transform(utf8.decoder).join();
    }
    httpClient.close();
    return data;
  }
}

class AsyncUpdateUiTest2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('异步UI更新')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                StreamBuilder<int>(
                  stream: counter(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error:${snapshot.error}');
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text('Nothing');
                      case ConnectionState.waiting:
                        return Text('等待数据...');
                      case ConnectionState.active:
                        return Text('${snapshot.data}');
                      case ConnectionState.done:
                        return Text('Stream 已关闭');
                    }
                    return Text('哇哦 失败了');
                  },
                )
              ],
            ),
          ),
        ));
  }

  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) => i).take(10);
  }
}
