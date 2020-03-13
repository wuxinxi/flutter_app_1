import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

void showTip(BuildContext context, String content) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text('提示'),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]);
      });
}

final Random random = Random(255);

Color getRandomColor() {
  return Color.fromARGB(
      255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
}

final materialColors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.cyan,
  Colors.green,
  Colors.teal,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.brown,
  Colors.blueGrey
];

final Random random2 = Random();

Color getRandomMaterialColor() {
  return materialColors[random.nextInt(materialColors.length - 1)];
}

