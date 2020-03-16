import 'package:flutter/material.dart';

import 'listener/notification.dart';

class GestureDetectorTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GestureDetectorState();
}

class GestureDetectorState extends State<GestureDetectorTestRoute> {
  String listenerName = '蹂躏我吧';

  //距离顶部的偏移
  double aTop = 0.0;

  //距离左边的偏移
  double aLeft = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 300.0,
          height: 45.0,
          child: Text(
            listenerName,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
        onDoubleTap: () => updateText('双击'),
        onLongPress: () => updateText('长按'),
        onTap: () => updateText('点击'));
//            DragText(),
  }

  void updateText(value) {
    setState(() => listenerName = value);
  }
}

class DragText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DragTextState();
}

class DragTextState extends State<DragText> {
  double _top = 0.0;
  double _left = 0.0;
  double width = 0;
  double height = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 100)).then((e) {
      setState(() {
        Size size = MediaQuery.of(context).size;
        width = size.width;
        height = size.height;
        _top = height / 2;
        _left = width / 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('手势')),
      body: Stack(
        children: <Widget>[
          Positioned(
            child: GestureDetectorTestRoute(),
            top: 0,
          ),
          Positioned(
            child: FlatButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationTestRoute()));
            }, child: Text('通知-实例')),
            top: 100,
          ),
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text('A'),
              ),
              onPanUpdate: (e) {
                if ((_left + e.delta.dx >= 1) &&
                    (_left + e.delta.dx <= width - 45)) {
                  setState(() => _left += e.delta.dx);
                }
                if ((_top + e.delta.dy >= 1) &&
                    (_top + e.delta.dy <= height - 120)) {
                  setState(() => _top += e.delta.dy);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
