import 'package:flutter/material.dart';

class AnimatedSwitcherCounterRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnimatedSwitcherCounterRouteState();
}

class AnimatedSwitcherCounterRouteState
    extends State<AnimatedSwitcherCounterRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AnimatedSwitcher'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  var tween =
                      Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
//                  return ScaleTransition(
//                    scale: animation,
//                    child: child,
//                  );
//                  return MySlideTransition(
//                    position: tween.animate(animation),
//                    child: child,
//                  );
                  return SlideTransitionX(
                    position: animation,
                    direction: AxisDirection.down,
                    child: child,
                  );
                },
                child: Text(
                  '$count',
                  //显式指定key，不同的key会被认为不用的Text，这样才会执行动画
                  key: ValueKey(count),
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              FlatButton(
                child: Container(
                  width: 120.0,
                  height: 45.0,
                  alignment: Alignment.center,
                  child: Text(
                    '+1',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  decoration: ShapeDecoration(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
                onPressed: () => setState(() => count += 1),
              ),
            ],
          ),
        ));
  }
}

class MySlideTransition extends AnimatedWidget {
  Animation<Offset> get position => listenable;
  final bool transFormHitTests;
  final Widget child;

  MySlideTransition(
      {Key key,
      @required Animation<Offset> position,
      this.transFormHitTests = true,
      this.child})
      : assert(position != null),
        super(key: key, listenable: position);

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    //动画执行反向时，调整x偏倚，实现从左边划出隐藏
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
        translation: offset,
        transformHitTests: transFormHitTests,
        child: child);
  }
}

class SlideTransitionX extends AnimatedWidget {
  Animation<double> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  //退出的方向
  final AxisDirection direction;
  Tween<Offset> tween;

  SlideTransitionX(
      {Key key,
      @required Animation<double> position,
      this.transformHitTests = true,
      this.child,
      this.direction = AxisDirection.down,
      this.tween})
      : assert(position != null),
        super(key: key, listenable: position) {
    switch (direction) {
      case AxisDirection.up:
        tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Offset offset = tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      child: child,
      transformHitTests: transformHitTests,
    );
  }
}
