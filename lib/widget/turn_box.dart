import 'package:flutter/material.dart';

enum TurnBoxStatus { DEFAULT, START, STOP }

class TurnBox extends StatefulWidget {
  final TurnBoxStatus status;
  final int speed; //执行动画的时长
  final Widget child;

  TurnBox(
      {Key key,
      this.status = TurnBoxStatus.DEFAULT,
      this.speed,
      @required this.child});

  @override
  State<StatefulWidget> createState() => TurnBoxState();
}

class TurnBoxState extends State<TurnBox> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.speed ?? 500));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      if (widget.status == TurnBoxStatus.STOP) {
        controller.stop();
      } else if (widget.status == TurnBoxStatus.START) {
        controller.animateTo(1);
        controller.repeat();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: controller,
      child: widget.child,
    );
  }
}
