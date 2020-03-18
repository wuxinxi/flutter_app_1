import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/util/toast.dart';
import 'package:path_provider/path_provider.dart';

import 'single_dio.dart';

class IoHttpRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('网络操作'),
      ),
      body: Column(
        children: <Widget>[
          LoginTest(),
        ],
      ),
    );
  }
}

class LoginTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginTestState();
}

class LoginTestState extends State<LoginTest> {
  var nameController = TextEditingController();
  var pwdController = TextEditingController();

  final registerUrl = 'http://49.235.141.166:8082/mall/userCenter/register';
  final loginUrl = 'http://49.235.141.166:8082/mall/userCenter/login';

  @override
  void initState() {
    super.initState();

    readUserInfo().then((List<String> user) {
      nameController.text = user[0];
      pwdController.text = user[1];
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    pwdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TextField(
            controller: nameController,
          ),
          TextField(
            controller: pwdController,
          ),
          Container(
            //宽度全充满
            width: double.infinity,
            child: RaisedButton(
              onPressed: () async {
                String name = nameController.text;
                String pwd = pwdController.text;
                if (name.isEmpty || pwd.isEmpty) {
                  Toast.toast(context, '缺少参数');
                } else {
                  Dio dio = DioFactory.instance.dio;
                  print('dio hashCode=${dio.hashCode}');
                  var params = Map();
                  params['user_name']=name;
                  params['user_pwd']=pwd;
                  params['user_mobile']=name;
                  Response response = await dio.post(registerUrl, data: params);
                  Toast.toast(context, '${response.statusCode}:${response.data}');
                }
              },
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text('注 册'),
              ),
              textColor: Colors.white,
              color: Colors.blue,
            ),
            margin: EdgeInsets.only(top: 20.0),
          ),
          Container(
            //宽度全充满
            width: double.infinity,
            child: RaisedButton(
              onPressed: () async {
                String name = nameController.text;
                String pwd = pwdController.text;
                if (name.isEmpty || pwd.isEmpty) {
                  Toast.toast(context, '缺少参数');
                } else {
                  Dio dio = DioFactory.instance.dio;
                  var params = Map();
                  params['user_name']=name;
                  params['user_pwd']=pwd;
                  var response=await dio.post(loginUrl,data: params);
                  if(response.statusCode==200){
                    saveUserInfo();
                  }
                  Toast.toast(context, '${response.statusCode}:${response.data}');
                }
              },
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text('登 录'),
              ),
              textColor: Colors.white,
              color: Colors.blue,
            ),
            margin: EdgeInsets.only(top: 20.0),
          ),
        ],
      ),
    );
  }

  Future<File> getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    print('路径：$dir');
    return File('$dir/user.txt');
  }

  Future<List<String>> readUserInfo() async {
    try {
      File file = await getLocalFile();
      List<String> userInfo = file.readAsLinesSync();
      return userInfo;
    } on FileSystemException {
      return ['default', 'default'];
    }
  }

  Future saveUserInfo() async {
    await (await getLocalFile())
        .writeAsString('${nameController.text}\n${pwdController.text}');
  }
}
