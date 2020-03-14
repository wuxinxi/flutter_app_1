import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/toast.dart';
import '../function/dialog_state.dart';

class MyDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  showDialog1();
                },
                child: Text('Dialog-1')),
            FlatButton(
                onPressed: () async {
                  bool delete = await showDialog2();
                  Toast.toast(context, delete == null ? '取消删除' : '已确认删除');
                },
                child: Text('Dialog-有返回值')),
            FlatButton(
                onPressed: () async {
                  int index = await showSimpleDialog();
                  Toast.toast(context, '选择了【$index】');
                },
                child: Text('语言选择')),
            FlatButton(
                onPressed: () async {
                  int index = await listSelectDialog();
                  Toast.toast(context, '$index');
                },
                child: Text('列表选择')),
            FlatButton(
                onPressed: () {
                  showCustomDialog();
                },
                child: Text('自定义')),
            FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyStateDialog()));
                },
                child: Text('具有状态的Dialog')),
            FlatButton(
                onPressed: () async {
                  String type = await _showModalBottomSheet();
                  if (type.isNotEmpty) {
                    Toast.toast(context, type);
                  }
                },
                child: Text('底部菜单')),
            FlatButton(
                onPressed: () async {
                  String value = await _showModalBottomSheet2();
                  Toast.toast(context, value);
                },
                child: Text('底部菜单-自定义')),
            FlatButton(
                onPressed: () {
                  //不知道为啥一直报错找不到：No Scaffold widget found
//                showBottomSheet(context: context, builder: (context) {
//                  return ListView.builder(itemCount: 30,
//                      itemBuilder: (context, index) => Text('$index'));
//                });
                },
                child: Text('底部菜单-全屏')),
            FlatButton(
                onPressed: () async {
                  await showLoadingDialog();
                  Future.delayed(Duration(seconds: 3))
                      .then((v) => Navigator.pop(context));
                },
                child: Text('Loading框')),
            FlatButton(
                onPressed: () async {
                  await showCustomLoadingDialog();
                  Future.delayed(Duration(seconds: 3))
                      .then((v) => Navigator.pop(context));
                },
                child: Text('Loading框-2')),
            FlatButton(
                onPressed: () async {
                  DateTime dateTime = await _showAndroidPicker();
                  Toast.toast(context, dateTime.toIso8601String());
                },
                child: Text('日历-Android')),
            FlatButton(
                onPressed: () async {
                  TimeOfDay dayTime = await _showAndroidTimePicker();
                  Toast.toast(context, dayTime.toString());
                },
                child: Text('时间-Android')),
            FlatButton(
                onPressed: () async {
                  DateTime dateTime = await _showIOSPicker();
                  Toast.toast(context, dateTime.toIso8601String());
                },
                child: Text('日历-IOS')),
          ],
        ),
      ),
    );
  }

  Future<void> showDialog1() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('我是第一个简单的Dialog'),
            actions: <Widget>[
              FlatButton(
                child: Text('确定'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<bool> showDialog2() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('我是第一个简单的Dialog'),
            actions: <Widget>[
              FlatButton(
                child: Text('取消'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('删除'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  Future<int> showSimpleDialog() async {
    int i = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('请选择语言'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, 0),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                  child: const Text('Java'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, 1),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                  child: const Text('Android'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, 2),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                  child: const Text('Flutter'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, 3),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                  child: const Text('Kotlin'),
                ),
              ),
            ],
          );
        });
    return i;
  }

  Future<int> listSelectDialog() async {
    int i = await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              children: <Widget>[
                ListTile(title: Text('请选择')),
                Expanded(
                  child: ListView.builder(
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('$index'),
                          onTap: () => Navigator.of(context).pop(index),
                        );
                      }),
                )
              ],
            ),
          );
        });
    return i;
  }

  //自定义dialog
  Future<T> customDialog<T>({
    @required BuildContext context,
    bool onTouchDisable = true,
    WidgetBuilder builder,
  }) {
    final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    return showGeneralDialog(
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }),
        );
      },
      context: context,
      //对话框以外的颜色
      barrierColor: Colors.black87,
      //点击对话框以外取消对话框
      barrierDismissible: onTouchDisable,
      //标签
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      //动画执行时间
      transitionDuration: const Duration(milliseconds: 150),
      //动画
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: child);
  }

  Future<bool> showCustomDialog() {
    return customDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('自定义Dialog'),
          content: Text('确定明天放假吗？'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Toast.toast(context, '确定放假');
                  Navigator.pop(context);
                },
                child: Text('确定')),
            FlatButton(
                onPressed: () {
                  Toast.toast(context, '必须放假');
                  Navigator.pop(context);
                },
                child: Text('必须放假'))
          ],
        );
      },
    );
  }

  final payLists = ['微信', '支付宝', '银行卡'];

  Future<String> _showModalBottomSheet() {
    return showModalBottomSheet<String>(
        elevation: 3.0,
        context: context,
        builder: (context) {
          //如果直接return ListView高度无法控制
          return Container(
            height: 180.0,
            alignment: Alignment.center,
            child: ListView.builder(
                itemCount: payLists.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${payLists[index]}'),
                    onTap: () => Navigator.pop(context, payLists[index]),
                  );
                }),
          );
        });
  }

  final strings = [
    '哎呦，他现在正在忙，你可以先处理其他快递，我会提醒他给你回复电话，可以吗？',
    '稍等，我马上就过来',
    '好的，辛苦放到门口或者附近的快递柜',
    '好的，辛苦放到附近的代收点',
    '不好意思等我下就到'
  ];

  Future<String> _showModalBottomSheet2() {
    String radioValue = '无话可说';
    return showModalBottomSheet<String>(
        context: context,
        builder: (context) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text('教教我怎么更好的回应快递吧',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              ),
              Builder(builder: (context) {
                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      //Expanded必须配合Row/Column/Flex使用否则会报错
                      children: <Widget>[
                        strings[0].length > 20
                            ? Expanded(
                                child: TextShapeWidget(strings[0]),
                              )
                            : TextShapeWidget(strings[0]),
                        Radio(
                            value: strings[0],
                            groupValue: radioValue,
                            onChanged: (val) {
                              (context as Element).markNeedsBuild();
                              radioValue = val;
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        strings[1].length >= 20
                            ? Expanded(
                                child: TextShapeWidget(strings[1]),
                              )
                            : TextShapeWidget(strings[1]),
                        Radio(
                            value: strings[1],
                            groupValue: radioValue,
                            onChanged: (val) {
                              (context as Element).markNeedsBuild();
                              radioValue = val;
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        strings[2].length >= 20
                            ? Expanded(
                                child: TextShapeWidget(strings[2]),
                              )
                            : TextShapeWidget(strings[2]),
                        Radio(
                            value: strings[2],
                            groupValue: radioValue,
                            onChanged: (val) {
                              (context as Element).markNeedsBuild();
                              radioValue = val;
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        strings[3].length >= 20
                            ? Expanded(
                                child: TextShapeWidget(strings[3]),
                              )
                            : TextShapeWidget(strings[3]),
                        Radio(
                            value: strings[3],
                            groupValue: radioValue,
                            onChanged: (val) {
                              (context as Element).markNeedsBuild();
                              radioValue = val;
                            }),
                      ],
                    )
                  ],
                );
              }),
              FlatButton(
                onPressed: () {
                  print('radioValue=$radioValue');
                  Navigator.pop(context, radioValue);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text('确定'),
                ),
              )
            ],
          );
        });
  }

  //全屏菜单
  //返回一个Controller
  PersistentBottomSheetController<int> _showBottomSheet() {
    return showBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('$index'),
                  onTap: () => Navigator.pop(context, index),
                );
              });
        });
  }

  showLoadingDialog() {
    showDialog(
        context: context,
        //不允许点击外部取消dialog
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text('加载中...'),
                )
              ],
            ),
          );
        });
  }

  showCustomLoadingDialog() {
    showDialog(
        context: context,
        //不允许点击外部取消dialog
        barrierDismissible: false,
        builder: (context) {
          //消除showDialog对宽度的限制
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: SizedBox(
              width: 280.0,
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text('加载中...'),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<DateTime> _showAndroidPicker() {
    var date = DateTime.now();
    return showDatePicker(
        context: context,
        //初始日期
        initialDate: date,
        //日期范围，开始,当前时间减360天
        firstDate: date.subtract(Duration(days: 360)),
        //日期范围，结尾，当前时间加360天
        lastDate: date.add(Duration(days: 360)));
  }

  Future<TimeOfDay> _showAndroidTimePicker() {
    var time = TimeOfDay.now();
    return showTimePicker(context: context, initialTime: time);
  }

  Future<DateTime> _showIOSPicker() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                    onDateTimeChanged: (DateTime value) {
                      print(value);
                    },
                    initialDateTime: date,
                    mode: CupertinoDatePickerMode.dateAndTime,
                    minimumDate: date,
                    maximumDate: date.add(Duration(days: 30))),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, date);
                },
                child: Text('确定'),
              )
            ],
          );
        });
  }
}

class TextShapeWidget extends StatelessWidget {
  final String text;

  TextShapeWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.pink]),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  topLeft: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0)))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    );
  }
}

class CircleCheckBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CircleCheckBoxState();
}

class CircleCheckBoxState extends State<CircleCheckBox> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          setState(() {
            check = !check;
          });
        },
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                  check ? Icons.check_circle : Icons.check_circle_outline,
                  size: 30.0,
                  color: check ? Colors.blue : Colors.blueGrey)),
        ),
      ),
    );
  }
}
