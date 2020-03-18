import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_1/util/toast.dart';
import 'package:path_provider/path_provider.dart';

class IoFileRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文件操作'),
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
              onPressed: () {
                String name = nameController.text;
                String pwd = pwdController.text;
                if (name.isEmpty || pwd.isEmpty) {
                  Toast.toast(context, '缺少参数');
                } else {
                  saveUserInfo();
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
