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
      body: Column(
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
              child: Text('具有状态的Dialog'))
        ],
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
}
