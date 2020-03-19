import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/bean/perfect_user.dart';
import 'package:flutter_app_1/bean/register.dart';
import 'package:flutter_app_1/util/toast.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:permission_handler/permission_handler.dart';
import 'single_dio.dart';

class IoHttpRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('网络操作'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              LoginTest(),
            ],
          ),
        ));
  }
}

class LoginTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginTestState();
}

class LoginTestState extends State<LoginTest> {
  var nameController = TextEditingController();
  var pwdController = TextEditingController();

  final registerUrl = 'http://192.168.1.70:8082/mall/userCenter/register';
  final loginUrl = 'http://192.168.1.70:8082/mall/userCenter/login';

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
                  params['user_name'] = name;
                  params['user_pwd'] = pwd;
                  params['user_mobile'] = name;
                  FormData data = FormData.fromMap({
                    'user_name': name,
                    'user_pwd': pwd,
                    'user_mobile': name,
                  });
                  Response response = await dio.post(registerUrl, data: data);

                  RegisterUserInfo userInfo= RegisterUserInfo.fromJson(response.data);
                  print(userInfo.message);
                  print(userInfo.code);
                  if(userInfo.code==200){
                    print(userInfo.data.toString());
                  }
//                  Toast.toast(
//                      context,
//                      response.statusCode == 200
//                          ? response.data
//                          : response.statusCode.toString());
//                  print(response.data.toString());
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
                  params['user_name'] = name;
                  params['user_pwd'] = pwd;
                  var response = await dio.post(loginUrl, data: params);
                  int code = response.statusCode;
                  if (code == 200) {
                    saveUserInfo();
                  }

                  Toast.toast(
                      context,
                      code == 200
                          ? response.data.toString()
                          : response.statusCode.toString());
                }
              },
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text('登 录'),
              ),
              textColor: Colors.white,
              color: Colors.blue,
            ),
            margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
          ),
          PerfectUserInfoRoute(),
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

class PerfectUserInfoRoute extends StatefulWidget {
  @override
  State<PerfectUserInfoRoute> createState() => PerfectUserInfoRouteState();
}

class PerfectUserInfoRouteState extends State<PerfectUserInfoRoute> {
  String userName = 'zhangsan';
  String userMobile = 'zhangsan';
  String userAddress = '安徽省亳州市';
  String userSign = '一名码工';
  String userPwd = '2';
  final perfectInfoUrl = 'http://192.168.1.70:8082/mall/userCenter/perfectInfo';
  String imagePath = '/head.jpg';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipOval(
            child: Image(
          image: FileImage(File(
              '/data/user/0/com.example.flutter_app_1/app_flutter/head.jpg')),
          height: 80.0,
          width: 80.0,
        )),
        TextField(
          decoration: InputDecoration(hintText: '用户名'),
          onChanged: (value) => userName = value,
        ),
        TextField(
          decoration: InputDecoration(hintText: '手机号'),
          onChanged: (value) => userMobile = value,
        ),
        TextField(
          decoration: InputDecoration(hintText: '地址'),
          onChanged: (value) => userAddress = value,
        ),
        TextField(
          decoration: InputDecoration(hintText: '签名'),
          onChanged: (value) => userSign = value,
        ),
        Container(
          //宽度全充满
          width: double.infinity,
          child: RaisedButton(
            onPressed: () async {
              String path = await imgPath();
              print('图片$path');

//
              Dio dio = DioFactory.instance.dio;
              FormData data = FormData.fromMap({
                'user_name': userName,
                'user_mobile': userMobile,
                'user_address': userAddress,
                'user_pwd': userPwd,
                'user_sign': userSign,
                //一定要记得添加await 否则取不到文件
                'user_icon': await MultipartFile.fromFile(
                  '/data/user/0/com.example.flutter_app_1/app_flutter/head.jpg',
                  filename: 'head.jpg',
                )
              });

              try {
                Response response = await dio.post(perfectInfoUrl, data: data);

                PerfectUserInfo userInfo= PerfectUserInfo.fromJson(response.data);
                print(userInfo.message);
                print(userInfo.code);
                if(userInfo.code==200){
                  print(userInfo.data.toString());
                }
//                Toast.toast(
//                    context,
//                    response.statusCode == 200
//                        ? response.data.toString()
//                        : response.statusCode.toString());
              } on DioError catch (e) {
                if (e.response != null) {
                  print(e.response.data);
                  print(e.response.headers);
                  print(e.response.request);
                } else {
                  // Something happened in setting up or sending the request that triggered an Error
                  print(e.request);
                  print(e.message);
                }
              }
            },
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text('提 交'),
            ),
            textColor: Colors.white,
            color: Colors.blue,
          ),
          margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
        ),
      ],
    );
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/image/img_head.jpg');
  }

  Future<bool> isExist(String path) async {
    return await File(path).exists();
  }

  Future<String> imgPath() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return dir + "/head.jpg";
  }

  Future requestPermission() async {
    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    // 申请结果
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission == PermissionStatus.granted) {
      Toast.toast(context, "权限申请通过");
    } else {
      Toast.toast(context, "权限申请被拒绝");
    }
  }
}
