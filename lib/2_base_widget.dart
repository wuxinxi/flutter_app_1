import 'package:flutter/material.dart';
import 'package:flutter_app_1/util/icons.dart';
import '3_form.dart';

class BaseWidget extends StatelessWidget {
  var userName;
  var userPwd;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('基础组件学习'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Text('字体样式(ttf)',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            //未生效（待解决）
            Text('我的字体样式是calibrii.ttf', style: MyFonts.calibriiStyle),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Text('Button',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('RaisedButton'),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text('FlatButton'),
                    onPressed: () {},
                  ),
                  OutlineButton(
                    child: Text('OutlineButton'),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.access_alarm),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
            ),
            Text('Icon Button',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton.icon(
                    label: Text('发送'),
                    icon: Icon(Icons.send),
                    onPressed: () {},
                  ),
                  FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      label: Text('添加')),
                  OutlineButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.delete),
                      label: Text('删除'))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
            ),
            Text('自定义Button样式',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  //使用padding 设置不同宽高
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
                    child: Text('登录'),
                  ),
                  textColor: Colors.white,
                  //button主题
                  colorBrightness: Brightness.dark,
                  color: Colors.blue,
                  //button按下的颜色
                  highlightColor: Colors.lightBlue,
                  //水波纹颜色(FlatButton无法实现水波纹)
                  splashColor: Colors.grey,
                  //按下时的阴影
                  highlightElevation: 3.0,
                  //禁用时的阴影
                  disabledElevation: 0.0,
                  //shape
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(30))),
                  onPressed: () {},
                ),
              ],
            ),
            Container(width: double.infinity, height: 1.0, color: Colors.grey),
            Container(
              margin: EdgeInsets.only(bottom: 10),
            ),
            Text('图片及ICON',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            Image.asset(
              'assets/image/img_head.jpg',
              width: 100.0,
            ),
            Image.network(
              'https://profile.csdnimg.cn/2/4/7/1_wu996489865',
              width: 100.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.person, color: Colors.green, size: 45.0),
                Icon(Icons.error, color: Colors.red, size: 45.0),
                Icon(Icons.cancel, color: Colors.red, size: 45),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(MyIcons.wechat, color: Colors.green, size: 45.0),
                Icon(MyIcons.bank, size: 45.0),
              ],
            ),
            Container(width: double.infinity, height: 1.0, color: Colors.grey),
            Container(margin: EdgeInsets.only(bottom: 10)),
            Text('单选框、复选框',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            SwitchAndCheckBoxTestRoute(),
            Container(width: double.infinity, height: 1.0, color: Colors.grey),
            Container(margin: EdgeInsets.only(bottom: 10)),
            Text('输入框及表单',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            Container(
              child: TextField(
                maxLength: 16,
                //超过最大长度变成红色【false】
                maxLengthEnforced: false,
                style: TextStyle(color: Colors.white),
                //光标的颜色
                cursorColor: Colors.red,
                keyboardType: TextInputType.number,
                //输入框装饰器
                decoration: InputDecoration(
                  //图标
                  icon: Icon(Icons.perm_identity),
                  //fillColor填充颜色是否生效
                  filled: true,
                  fillColor: Colors.blue,
                  hintText: '用户名',
                  labelText: '用户名',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.grey[300]),
                ),
                onChanged: (value) {
                  userName = value;
                },
              ),
              margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
            ),
            Container(
              child: TextField(
                maxLength: 16,
                //超过最大长度变成红色【false】
                maxLengthEnforced: false,
                //是否隐藏文字
                obscureText: true,
                //输入类型（数字）
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.white),
                //光标的颜色
                cursorColor: Colors.red,
                //输入框装饰器
                decoration: InputDecoration(
                  //图标
                  icon: Icon(Icons.lock),
                  //fillColor填充颜色是否生效
                  filled: true,
                  fillColor: Colors.blue,
                  hintText: '密码',
                  labelText: '密码',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.grey[300]),
                ),
                onChanged: (value) {
                  userPwd = value;
                },
              ),
              margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
            ),

            RaisedButton(
              child: Padding(
                padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
                child: Text('登录'),
              ),
              textColor: Colors.white,
              //button主题
              colorBrightness: Brightness.dark,
              color: Colors.blue,
              //button按下的颜色
              highlightColor: Colors.lightBlue,
              //水波纹颜色(FlatButton无法实现水波纹)
              splashColor: Colors.grey,
              //按下时的阴影
              highlightElevation: 3.0,
              //禁用时的阴影
              disabledElevation: 0.0,
              //shape
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(30))),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FormSimple();
                }));
              },
            ),
            Container(width: double.infinity, height: 1.0, color: Colors.grey),
            Container(margin: EdgeInsets.only(bottom: 10)),
            Text('进度指示器',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            LinearProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
            Container(margin: EdgeInsets.only(bottom: 20)),
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                strokeWidth: 5.0,
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
            Container(margin: EdgeInsets.only(bottom: 20)),
            ProgressSimple(),
            Container(margin: EdgeInsets.only(bottom: 20)),
          ],
        ),
      ),
    );
  }
}

//单选框、复选框
class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SwitchAndCheckBoxTextRouteState();
}

class SwitchAndCheckBoxTextRouteState
    extends State<SwitchAndCheckBoxTestRoute> {
  bool switchSelected = false;
  bool checkBoxSelected = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Switch(
          value: switchSelected,
          onChanged: (value) {
            setState(() {
              switchSelected = value;
            });
          },
        ),
        Checkbox(
          value: checkBoxSelected,
          activeColor: Colors.red,
          onChanged: (value) {
            setState(() {
              checkBoxSelected = value;
            });
          },
        )
      ],
    );
  }
}

//进度指示器
class ProgressSimple extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProgressSimpleState();
}

class ProgressSimpleState extends State<ProgressSimple>
    with SingleTickerProviderStateMixin {
  var count = 1;
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    animationController.forward();
    animationController.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void setProgress() {
    setState(() {
      if (count >= 10) {
        count = 0;
      }
      count += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        LinearProgressIndicator(
          backgroundColor: Colors.grey,
          valueColor: AlwaysStoppedAnimation(Colors.blue),
          value: count / 10.0,
        ),
        Container(margin: EdgeInsets.only(bottom: 20)),
        SizedBox(
          height: 100.0,
          width: 100.0,
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            strokeWidth: 10.0,
            valueColor: ColorTween(begin: Colors.grey,end: Colors.lightBlue).animate(animationController),
            value: animationController.value,
          ),
        ),
        Container(margin: EdgeInsets.only(bottom: 20)),
        SizedBox(
          height: 100.0,
          width: 100.0,
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            strokeWidth: 5.0,
            valueColor: AlwaysStoppedAnimation(Colors.red),
            value: count / 10.0,
          ),
        ),
        RaisedButton(
          child: Text('增加进度 ${count * 10}'),
          onPressed: () {
            setProgress();
          },
        )
      ],
    );
  }
}
