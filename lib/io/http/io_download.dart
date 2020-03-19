import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/io/http/single_dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DownloadRouteState();
}

class DownloadRouteState extends State<DownloadRoute> {
  final path = 'http://192.168.1.70:8082/media/apk/s8.apk';
  double progress = .0;
  String status = '下载';

  @override
  Widget build(BuildContext context) {
    ThemeData data = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('下载'),
      ),
      body: Column(
        children: <Widget>[
          Text('进度：${(progress * 100).toInt()}'),
          Container(
            padding: EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              value: progress,
              valueColor: AlwaysStoppedAnimation(data.primaryColor),
              backgroundColor: Colors.grey,
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            width: double.infinity,
            height: 45.0,
            color: data.primaryColor,
            child: FlatButton(
                onPressed: () async {
                  Dio dio = DioFactory.instance.dio;
                  await dio.download(
                      path,
                      await getSavePath(
                        'demo.apk',
                      ), onReceiveProgress: (int count, int total) {
                    setState(() {
                      progress = count / total;
                    });
                  });
                  setState(() {
                    status = '重新下载';
                  });
                },
                child: Text(
                  status,
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                )),
          )
        ],
      ),
    );
  }

  Future<String> getSavePath(fileName) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return '$dir/$fileName';
  }
}
