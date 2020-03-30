import 'package:flutter/material.dart';

class ChipDemo extends StatefulWidget {
  @override
  _ChipDemoState createState() => _ChipDemoState();
}

class _ChipDemoState extends State<ChipDemo> {
  List<String> _sub = ['Java', 'Android', 'Flutter'];
  String tag = 'defalut';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chip-小碎片 Wrap-换行 Divider-分隔符...'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              //自动换行
              Wrap(
                //行间距
                runSpacing: 10.0,
                //小部件之间的间距:
                spacing: 10.0,
                children: <Widget>[
                  Chip(
                      label: Text('唐人'),
                      elevation: 4.0,
                      backgroundColor: Colors.orange,
                      shadowColor: Colors.pinkAccent,
                      onDeleted: () {},
                      deleteButtonTooltipMessage: '你长按了我',
                      avatar: ClipOval(
                        child: Image.network(
                            'http://www.xxstudy.cn/static/images/avatar_15.png'),
                      )),
                  Chip(
                      label: Text('唐人'),
                      elevation: 4.0,
                      backgroundColor: Colors.orange,
                      shadowColor: Colors.pinkAccent,
                      onDeleted: () {},
                      deleteButtonTooltipMessage: '你长按了我',
                      avatar: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text('#',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0)),
                        backgroundImage: NetworkImage(
                            'http://www.xxstudy.cn/static/images/avatar_15.png'),
                      )),
                ],
              ),
              //分割线
              Divider(
                height: 10.0,
                //厚度，默认1.0
                thickness: 2.0,
                //颜色
                color: Colors.red,
                //左margin
                indent: 10.0,
                //右margin
                endIndent: 10.0,
              ),
              Wrap(
                spacing: 10.0,
                children: _sub.map((sub) {
                  return ActionChip(
                      avatar: Icon(Icons.delete),
                      backgroundColor: Colors.blue,
                      tooltip: '长按我',
                      label: Text(sub),
                      onPressed: () => setState(() => _sub.remove(sub)));
                }).toList(),
              ),
              Divider(),
              Wrap(
                spacing: 10.0,
                children: _sub.map((sub) {
                  return FilterChip(
                    label: Text(sub, style: TextStyle(color: Colors.white)),
                    selectedColor: Colors.blue,
                    checkmarkColor: Colors.pinkAccent,
                    backgroundColor: Colors.black87,
                    selected: tag.contains(sub),
                    onSelected: (bool value) {
                     setState(() {
                       if (!tag.contains(sub)) {
                         tag = sub;
                       }
                     });
                    },
                  );
                }).toList(),
              ),
              Divider(),
              Wrap(
                spacing: 10.0,
                children: _sub.map((sub) {
                  return ChoiceChip(
                    label: Text(sub, style: TextStyle(color: Colors.white)),
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.black87,
                    selected: tag.contains(sub),
                    onSelected: (bool value) {
                      setState(() {
                        if (!tag.contains(sub)) {
                          tag = sub;
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() => _sub = ['Java', 'Android', 'Flutter']);
            },
            child: Icon(Icons.refresh)));
  }
}
