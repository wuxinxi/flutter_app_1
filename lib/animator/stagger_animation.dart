import 'package:flutter/material.dart';

class StaggerAnimationTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StaggerAnimationTestRouteState();
}

class StaggerAnimationTestRouteState extends State<StaggerAnimationTestRoute>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('组合动画')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    border: Border.all(color: Colors.black.withOpacity(0.5))),
                child: StaggerAnimation(
                  controller: controller,
                ),
              ),
              FlatButton(
                child: Text('开始'),
                onPressed: () {
                  playAnimation();
                },
              )
            ],
          ),
        ));
  }

  Future playAnimation() async {
    try {
      //先正向执行
      await controller.forward().orCancel;
      //在反向
      await controller.reverse().orCancel;
    } on TickerCanceled {}
  }
}

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  StaggerAnimation({Key key, this.controller}) : super(key: key) {
    height = Tween(begin: .0, end: 300.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.6, /*间隔 前60%动画时间*/ curve: Curves.ease)));

    color = ColorTween(begin: Colors.green, end: Colors.red).animate(
        CurvedAnimation(
            parent: controller, curve: Interval(0.0, 0.6, curve: Curves.ease)));

    padding = Tween<EdgeInsets>(
            begin: EdgeInsets.only(left: .0), end: EdgeInsets.only(left: 100.0))
        .animate(CurvedAnimation(
            parent: controller, curve: Interval(0.6, 1.0, curve: Curves.ease)));
  }

  Widget buildAnimation(context, child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: buildAnimation);
  }
}
