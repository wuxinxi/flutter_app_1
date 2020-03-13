import 'package:flutter/material.dart';
import 'dart:math' as math;
import '5_6_ui.dart';
import '5_6_ui2.dart';

class Box extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('容器类组件'),
      ),
      body: Column(
        children: <Widget>[
          Text('装饰容器',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0)),
          DecoratedBox(
              decoration: ShapeDecoration(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.red, width: 3.0))),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
                child: Text('自定义按钮',
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
              )),
          Container(
            margin: EdgeInsets.only(top: 5),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.red, Colors.orange[700]]),
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0)
                ]), //渐变
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
              child: Text('渐变按钮',
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
          ),
          Container(height: 1.0, width: double.infinity, color: Colors.grey),
          Text('Transform',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0)),
          MyTransform(),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Ui();
              }));
            },
            child: Text(
              'UI导航',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            highlightColor: Colors.blueAccent,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Ui2();
              }));
            },
            child: Text(
              'UI导航2',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            highlightColor: Colors.blueAccent,
          )
        ],
      ),
    );
  }
}

class MyTransform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.black,
          child: Transform(
            transform: Matrix4.skewY(0.3), //Y轴歪斜0.3°
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.deepOrange,
              child: const Text('Transforom Test for me'),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 70.0),
        ),
        Container(
            color: Colors.grey,
            height: 100.0,
            width: double.infinity,
            child: Transform.translate(
                offset: Offset(100.0, 50.0),
                //将Text右移100像素，下移50像素
                child: Text(
                  'translate',
                  style: TextStyle(fontSize: 18.0),
                ))),
        Container(
          margin: EdgeInsets.only(top: 30.0),
        ),
        Transform.rotate(
          angle: math.pi / 2,
          child: Text(
            '旋转90°',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
        ),
        Transform.scale(
          scale: 1.5,
          child: Text('文字缩放1.5倍'),
        )
      ],
    );
  }
}
