import 'package:flutter/material.dart';
import '../util/toast.dart';

class MyStateDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyStateDialogSate();
}

class MyStateDialogSate extends State<MyStateDialog> {
  bool withTree = false;

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return Scaffold(
      appBar: AppBar(
        title: Text('状态Dialog'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            //错误原因：setState只会rebuild当前context的子树，对话框是在showDialog单独创建的，因此调用在State的context中调用setState是无效的
            child: Text('错误方式'),
            onPressed: () async {
              bool success = await showDeleteConfirmDialog();
              Toast.toast(context, success.toString());
            },
          ),
          FlatButton(
            //根据1，我们吧CheckBox抽离到StatefulWidget中
            child: Text('方式1'),
            onPressed: () async {
              bool success = await showDeleteConfirmDialog1();
              Toast.toast(context, success.toString());
            },
          ),
          FlatButton(
            //2中虽然解决了对话框更新的问题，但是需要单独封装在StatefulWidget,显然太麻烦了
            //builder组件可以获取到组件所在的真正的Context
            child: Text('方式2'),
            onPressed: () async {
              bool success = await showDeleteConfirmDialog2();
              Toast.toast(context, success.toString());
            },
          ),
          FlatButton(
            //一行代码解决，在错误方式中进行强制重构
            child: Text('方式3'),
            onPressed: () async {
              bool success = await showDeleteConfirmDialog3();
              Toast.toast(context, success.toString());
            },
          ),
          FlatButton(
            //在3的基础上继续调优，缩小rebuild的范围
            child: Text('方式4'),
            onPressed: () async {
              bool success = await showDeleteConfirmDialog4();
              Toast.toast(context, success.toString());
            },
          )
        ],
      ),
    );
  }

  //错误方法
  Future<bool> showDeleteConfirmDialog() {
    withTree = false; //默认复选框不选中
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('您确定要删除当前文件吗？'),
                Row(
                  children: <Widget>[
                    Text('同时删除子目录？'),
                    Checkbox(
                        value: withTree,
                        onChanged: (bool value) {
                          setState(() {
                            withTree = !withTree;
                          });
                        })
                  ],
                )
              ],
            ),
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
                  Navigator.pop(context, withTree);
                },
              ),
            ],
          );
        });
  }

  //方法1
  Future<bool> showDeleteConfirmDialog1() {
    withTree = false; //默认复选框不选中
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('您确定要删除当前文件吗？'),
                Row(
                  children: <Widget>[
                    Text('同时删除子目录？'),
                    DialogCheckBox(
                        value: withTree,
                        onChanged: (bool value) {
                          setState(() {
                            withTree = !withTree;
                          });
                        })
                  ],
                )
              ],
            ),
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
                  Navigator.pop(context, withTree);
                },
              ),
            ],
          );
        });
  }

  //方法2
  Future<bool> showDeleteConfirmDialog2() {
    withTree = false; //默认复选框不选中
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('您确定要删除当前文件吗？'),
                Row(
                  children: <Widget>[
                    Text('同时删除子目录？'),
                    StatefulBuilder(builder: (context, state) {
                      return Checkbox(
                          value: withTree,
                          onChanged: (bool value) {
                            state(() {
                              withTree = !withTree;
                            });
                          });
                    })
                  ],
                )
              ],
            ),
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
                  Navigator.pop(context, withTree);
                },
              ),
            ],
          );
        });
  }

  //方法3使用element.markNeedsBuild
  Future<bool> showDeleteConfirmDialog3() {
    withTree = false; //默认复选框不选中
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('您确定要删除当前文件吗？'),
                Row(
                  children: <Widget>[
                    Text('同时删除子目录？'),
                    Checkbox(
                        value: withTree,
                        onChanged: (bool value) {
                          setState(() {
                            // 此时context为对话框UI的根Element，我们
                            // 直接将对话框UI对应的Element标记为dirty
                            (context as Element).markNeedsBuild();
                            withTree = !withTree;
                          });
                        })
                  ],
                )
              ],
            ),
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
                  Navigator.pop(context, withTree);
                },
              ),
            ],
          );
        });
  }

  //方法4使用element.markNeedsBuild，但是缩小重构范围，仅仅重构CheckBox
  Future<bool> showDeleteConfirmDialog4() {
    withTree = false; //默认复选框不选中
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('您确定要删除当前文件吗？'),
                Row(
                  children: <Widget>[
                    Text('同时删除子目录？'),
                    // 通过Builder来获得构建Checkbox的`context`，
                    // 这是一种常用的缩小`context`范围的方式
                    Builder(builder: (context) {
                      return Checkbox(
                          value: withTree,
                          onChanged: (bool value) {
                            setState(() {
                              (context as Element).markNeedsBuild();
                              withTree = !withTree;
                            });
                          });
                    }),
                  ],
                )
              ],
            ),
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
                  Navigator.pop(context, withTree);
                },
              ),
            ],
          );
        });
  }
}

class DialogCheckBox extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final bool value;

  DialogCheckBox({Key key, @required this.onChanged, this.value});

  @override
  State<StatefulWidget> createState() => DialogCheckBoxState();
}

class DialogCheckBoxState extends State<DialogCheckBox> {
  bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      onChanged: (v) {
        widget.onChanged(v);
        setState(() {
          value = v;
        });
      },
      value: value,
    );
  }
}

//方法2 利用builder
class StatefulBuilder extends StatefulWidget {
  final StatefulWidgetBuilder builder;

  StatefulBuilder({Key key, @required this.builder})
      : assert(builder != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => StatefulBuilderState();
}

class StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(BuildContext context) => widget.builder(context, setState);
}
