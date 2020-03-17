import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    rotateAnimation = Tween(begin: 0.0, end: 1.0).animate(controller);
    scaleAnimation = Tween(begin: 0.0, end: 60.0).animate(scaleController)
      ..addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RotationTransition(
          child: ScaleTransition(
            child: Icon(
              Icons.refresh,
              size: scaleAnimation.value,
            ),
            scale: scaleController,
          ),
          turns: controller,
        ),
        FlatButton(
          child: Text('显示'),
          onPressed: () => scaleController.forward(),
        ),
        FlatButton(
          child: Text('隐藏'),
          onPressed: () async {
            await scaleController.reverse();
            controller.stop();
          },
        ),
        FlatButton(
          child: Text('旋转'),
          onPressed: () {
            controller.forward();
            controller.repeat();
          },
        ),
      ],
    );
  }
}
