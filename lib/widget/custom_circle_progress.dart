import 'dart:math';

import 'package:flutter/material.dart';

class CustomCircleProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: ShapeDecoration(
          shape: CircleBorder(
              side: BorderSide(color: Colors.pinkAccent, width: 10.0))),
    );
  }
}

class CustomCircleProgressPainter extends CustomPainter {
  final double strokeWidth;
  final bool strokeCapRound;
  final double value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double radius;
  final List<double> stops;

  CustomCircleProgressPainter(
      {this.strokeWidth: 10.0,
      this.strokeCapRound: false,
      this.value,
      this.backgroundColor = const Color(0xFFEEEEEE),
      @required this.colors,
      this.total = 2 * pi,
      this.radius,
      this.stops});

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius);
    }

    double _offset = strokeWidth / 2.0;
    double _value = value ?? .0;
    // clamp 大于最大值取最大值小余最小值取最小值
    _value = _value.clamp(.0, 1.0) * total;
    double _start=.0;

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
