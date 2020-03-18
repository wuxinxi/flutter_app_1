import 'package:flutter/material.dart';

import 'io/file/io_file.dart';
import 'io/http/io_http.dart';
import 'io/http/io_socket.dart';

class IoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文件操作与网络请求'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => IoFileRoute()));
              },
              child: Text('文件操作')),
          FlatButton(onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => IoHttpRoute()));
          }, child: Text('Http请求')),
          FlatButton(onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WebSocketRoute()));
          }, child: Text('WebSocket')),
        ],
      ),
    );
  }
}
