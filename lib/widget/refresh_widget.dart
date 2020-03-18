import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'custom_paint.dart';

class ProgressWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProgressWidgetState();
}

class ProgressWidgetState extends State<ProgressWidget>
    with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController scaleController;
  Animation<double> rotateAnimation;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    rotateAnimation = Tween(begin: 0.0, end: 1.0).animate(controller);
    scaleAnimation = Tween(begin: 0.0, end: 60.0).animate(scaleController)
      ..addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      children: <Widget>[
        RotationTransition(
          child: ScaleTransition(
            child: Icon(
              Icons.refresh,
              color: themeData.primaryColor,
              size: scaleAnimation.value,
            ),
            scale: scaleController,
          ),
          turns: controller,
        ),
        FlatButton(
          child: Text('显示'),
          onPressed: (){
            controller.forward();
            controller.repeat();
            scaleController.forward();
          },
        ),
        FlatButton(
          child: Text('隐藏'),
          onPressed: () async {
            await scaleController.reverse();
            controller.stop();
          },
        ),
      ],
    );
  }
}
