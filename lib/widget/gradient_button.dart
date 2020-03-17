import 'package:flutter/material.dart';

//渐变按钮
class GradientButton extends StatelessWidget {
  final BorderRadius borderRadius;
  final List<Color> colors;
  final double width, height;
  final Widget child;
  final GestureTapCallback onPressed;
  final bool isEnable;
  final Color disEnableColors;

  GradientButton(
      {this.borderRadius,
      this.colors,
      this.width,
      this.height,
      this.isEnable = true,
      this.disEnableColors = Colors.grey,
      @required this.child,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];

    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: isEnable ? null : disEnableColors,
          gradient: isEnable ? LinearGradient(colors: _colors) : null),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: isEnable ? onPressed : null,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold), child: child),
            ),
          ),
        ),
      ),
    );
  }
}
