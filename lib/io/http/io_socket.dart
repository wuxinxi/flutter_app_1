import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WebSocketRouteState();
}

class WebSocketRouteState extends State<WebSocketRoute> {
  StringBuffer buffer = StringBuffer('初始化...\n');
  IOWebSocketChannel channel;

  @override
  void initState() {
    channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          height: 400.0,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 2.0)),
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    buffer.write('网络连接失败\n');
                  } else if (snapshot.hasData) {
                    buffer.write(snapshot.data + '\n');
                  }
                  return Container(
                    width: double.infinity,
                    height: 350.0,
                    child: Text(buffer.toString()),
                  );
                },
              ),
              Container(
                width: double.infinity,
                height: 45.0,
                child: RaisedButton(
                  onPressed: () {
                    channel.sink.add(DateTime.now().toIso8601String());
                  },
                  child: Text('发送数据'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
