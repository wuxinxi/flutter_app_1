import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_1/widget/gradient_button.dart';
import 'package:flutter_app_1/widget/progress_widget.dart';
import 'package:flutter_app_1/widget/turn_box.dart';

class CustomWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomWidgetState();
}

class CustomWidgetState extends State<CustomWidget> {
  TurnBoxStatus status = TurnBoxStatus.DEFAULT;
  TurnBoxStatus status2 = TurnBoxStatus.DEFAULT;
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义Widget'),
      ),
      body: Column(
        children: <Widget>[
          Text('自定义渐变按钮'),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: GradientButton(
              child: Text('按我'),
              onPressed: () => setState(() {
                status = status == TurnBoxStatus.STOP
                    ? TurnBoxStatus.START
                    : TurnBoxStatus.STOP;

                visible = status == TurnBoxStatus.STOP;
              }),
              borderRadius: BorderRadius.circular(3.0),
              colors: [Colors.blue, Colors.purpleAccent],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: GradientButton(
              child: Text('按我2'),
              onPressed: () {
                setState(() {
                  status2 = status2 == TurnBoxStatus.STOP
                      ? TurnBoxStatus.START
                      : TurnBoxStatus.STOP;
                });
              },
              borderRadius: BorderRadius.circular(3.0),
              colors: [Colors.pinkAccent, Colors.purpleAccent],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
          ),
          Container(
            color: Colors.grey,
            height: 1.0,
            width: double.infinity,
          ),
          Text('自定义旋转'),
          Offstage(
            offstage: visible,
            child: TurnBox(
              status: status,
              child: Icon(
                Icons.refresh,
                color: Colors.purpleAccent,
                size: 50.0,
              ),
            ),
          ),
          Text('自定义旋转'),
          ProgressWidget(),
        ],
      ),
    );
  }
}
