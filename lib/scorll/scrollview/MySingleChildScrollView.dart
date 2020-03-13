import 'package:flutter/material.dart';
import 'dart:math';

class MySingleChildScrollView extends StatelessWidget {
  final String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SingleChildScrollView'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: str.split("").map((c) {
                return Text(
                  c,
                  style: TextStyle(fontSize: 18.0, color: getRandomColor()),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  getRandomColor() {
    return Color.fromARGB(255, Random.secure().nextInt(255),
        Random.secure().nextInt(255), Random.secure().nextInt(255));
  }
}
