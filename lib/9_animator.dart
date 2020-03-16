import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'animator/animated_switcher.dart';
import 'animator/hero_route_second.dart';
import 'animator/stagger_animation.dart';

/// Curve:用来描述动画执行过程
/// linear:匀速
/// decelerate：匀减速
/// ease：开始加速，后面减速
/// easeIn:开始慢后面快
/// easeOut:开始快，后面慢
/// easeInOut:开始慢，然后加速，最后在减速

class ScaleAnimationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScaleAnimationRouteState();
}

class ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with /*SingleTickerProviderStateMixin*/ TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  Animation<double> animation2;
  AnimationController controller2;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = Tween(begin: 0.0, end: 100.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut))
      ..addListener(() => setState(() => {}));

    controller2 =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation2 = Tween(begin: 10.0, end: 100.0).animate(controller2);
    animation2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束，开始反向执行
        controller2.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复后在正向开始
        controller2.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画'),
      ),
      body: Column(
        children: <Widget>[
          Text('普通写法'),
          Image.asset('assets/image/img_head.jpg',
              width: animation.value, height: animation.value),
          FlatButton(
            child: Text('执行动画'),
            onPressed: () async {
              await controller.forward();
              //执行完成后进行恢复
              controller.reset();
            },
          ),
          Text('AnimatedBuilder优化'),
          SimpleTransition(
              child: InkWell(
                child: Image.asset(
                  'assets/image/img_head.jpg',
                ),
                onTap: () => controller2.stop(),
              ),
              animation: animation2),
          FlatButton(
            child: Text('执行动画'),
            onPressed: () async {
              await controller2.forward();
              //执行完成后进行恢复
//              controller2.reset();
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
          ),
          Text('Hero 共享元素'),
          InkWell(
            child: Hero(
              tag: 'avatar',
              child: ClipOval(
                child: Image.asset(
                  'assets/image/img_head.jpg',
                  width: 100.0,
                  height: 100.0,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HeroRoute()));
              //Dialog 貌似不支持hero
//              showAvatarDialog();
            },
          ),
          FlatButton(child: Text('组合动画'), onPressed: () {
            Navigator.push(context,CupertinoPageRoute(builder: (context)=>StaggerAnimationTestRoute()));
          }),
          FlatButton(child: Text('AnimatedSwitcher'), onPressed: () {
            Navigator.push(context,CupertinoPageRoute(builder: (context)=>AnimatedSwitcherCounterRoute()));
          })
        ],
      ),
    );
  }

  Future showAvatarDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: InkWell(
              child: Hero(
                tag: 'avatar',
                child: Image.asset(
                  'assets/image/img_head.jpg',
                  height: 300.0,
                  width: 300.0,
                  fit: BoxFit.fill,
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
          );
        });
  }
}

//封装
class SimpleTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  SimpleTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (context, child) {
          return Container(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        });
  }
}
