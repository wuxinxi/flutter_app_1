//State状态管理
//1. 如果状态是用户数据，如复选框的选中状态、滑块的位置，则该状态最好由父Widget管理。
//2. 如果状态是有关界面外观效果的，例如颜色、动画，那么状态最好由Widget本身来管理。
//3. 如果某一个状态是不同Widget共享的则最好由它们共同的父Widget管理。
//如果不确定该怎么管理状态时，推荐父widget管理

import 'package:flutter/material.dart';

class TapBoxA extends StatefulWidget {
  TapBoxA({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TapBoxAState();
}

class TapBoxAState extends State<TapBoxA> {
  bool active = false;

  void handleTap() {
    setState(() {
      active = !active;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        decoration:
            BoxDecoration(color: active ? Colors.lightGreen : Colors.grey),
      ),
    );
  }
}
