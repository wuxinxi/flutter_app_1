import 'package:flutter/material.dart';

class OverAnimationTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('过渡动画'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedDecoratedBox1Test(),
        ],
      ),
    );
  }
}

class AnimatedDecoratedBox1Test extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnimatedDecoratedBox1TestState();
}

class AnimatedDecoratedBox1TestState extends State<AnimatedDecoratedBox1Test> {
  @override
  Widget build(BuildContext context) {
    Color decorationColor = Colors.blue;

    return AnimatedDecoratedBox1(
      decoration: BoxDecoration(color: decorationColor),
      duration: Duration(seconds: 1),
      child: FlatButton(
          onPressed: () => setState(() => decorationColor = Colors.red),
          child: Text(
            'AnimatedDecoratedBox1',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          )),
    );
  }
}

class AnimatedDecoratedBox1 extends StatefulWidget {
  final BoxDecoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration reverseDuration;

  AnimatedDecoratedBox1(
      {Key key,
      @required this.decoration,
      this.child,
      this.duration,
      this.curve = Curves.linear,
      this.reverseDuration});

  @override
  State<StatefulWidget> createState() => AnimatedDecoratedBox1State();
}

class AnimatedDecoratedBox1State extends State<AnimatedDecoratedBox1>
    with SingleTickerProviderStateMixin {
  @protected
  AnimationController get controller => _controller;
  AnimationController _controller;

  Animation<double> get animation => _animation;
  Animation<double> _animation;

  DecorationTween tween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
        reverseDuration: widget.reverseDuration);
    tween = DecorationTween(begin: widget.decoration);
    updateCurve();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return DecoratedBox(
          decoration: tween.animate(_animation).value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(AnimatedDecoratedBox1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.curve != oldWidget.curve) {
      updateCurve();
    }
    _controller.duration = widget.duration;
    _controller.reverseDuration = widget.reverseDuration;
    if (widget.decoration != (tween.end ?? tween.begin)) {
      tween
        ..begin = tween.evaluate(_animation)
        ..end = widget.decoration;
      _controller
        ..value = 0.0
        ..forward();
    }
  }

  void updateCurve() {
    if (widget.curve != null) {
      _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    } else {
      _animation = _controller;
    }
  }
}
