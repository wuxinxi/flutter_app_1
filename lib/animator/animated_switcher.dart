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
                  return ScaleTransition(
                    scale: animation,
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
              )
            ],
          ),
        ));
  }
}

class MySlideTransition extends AnimatedWidget{
  @override
  Widget build(BuildContext context) {
    return null;
  }

}
