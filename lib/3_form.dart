import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FormSimple extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('输入框及表单'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                '普通输入框',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              Container(
                child: TextField(
                  autofocus: false,
                  controller: nameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      labelText: '用户名',
                      labelStyle: TextStyle(fontSize: 12.0),
                      hintText: '手机号/邮箱/用户名'),
                ),
                margin: EdgeInsets.only(left: 10, right: 10),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  maxLength: 16,
                  maxLengthEnforced: true,
                  controller: pwdController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      labelText: '密码',
                      labelStyle: TextStyle(fontSize: 12.0),
                      hintText: '用户密码'),
                ),
                margin: EdgeInsets.only(left: 10, right: 10),
              ),
              Container(
                //宽度全充满
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    final userName = nameController.text;
                    final userPwd = pwdController.text;
                    showDialog(
                        context,
                        (userName.isEmpty || userPwd.isEmpty)
                            ? '缺少必填信息'
                            : '用户名：${nameController.text}\n用户密码：${pwdController.text}');
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text('登 录'),
                  ),
                  textColor: Colors.white,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                ),
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
              Text(
                '表单输入框',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              FormRoute(),
            ],
          ),
        ));
  }
}

void showDialog(BuildContext context, String content) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('提示'),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

class FormRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FromRouteState();
}

class FromRouteState extends State<FormRoute> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final pwdController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Form(
          key: formKey,
          autovalidate: true, //开启校验
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    labelText: '用户名',
                    labelStyle: TextStyle(fontSize: 13.0),
                    hintText: '手机号/邮箱/用户名'),
                validator: (value) {
                  //验证
                  return value.trim().isEmpty ? '用户名不能为空' : null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                maxLength: 16,
                maxLengthEnforced: true,
                controller: pwdController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    labelText: '密码',
                    labelStyle: TextStyle(fontSize: 12.0),
                    hintText: '用户密码'),
                validator: (value) {
                  return value.trim().length < 5 ? '密码不能少于6位' : null;
                },
              ),
              Container(
                //宽度全充满
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      showDialog(context,
                          '用户名：${nameController.text}\n用户密码：${pwdController.text}');
                    } else {
                      showDialog(context, '缺少必填参数');
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text('登 录'),
                  ),
                  textColor: Colors.white,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ));
  }
}

class TextFiledWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TextFiledState();
}

class TextFiledState extends State<TextFiledWidget> {
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    textEditingController.text = 'default';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      controller: textEditingController,
      autofocus: true,
      keyboardType: TextInputType.text,
      obscureText: true,
      maxLength: 16,
      maxLengthEnforced: true,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline),
          labelText: '密码',
          labelStyle: TextStyle(fontSize: 12.0),
          hintText: '用户密码'),
    );
  }
}
