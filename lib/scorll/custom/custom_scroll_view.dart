import 'dart:math';

import 'package:flutter/material.dart';


/// 显然这个时候是不行的，这个时候就需要CustomScrollView
class AddScrollView extends StatelessWidget {
  final List<Color> colors = getRandomColors();

  @override
  Widget build(BuildContext context) {
    Divider divider = Divider(color: Colors.black);
    return Scaffold(
        appBar: AppBar(title: Text('GridView+ListView')),
        body: Column(
          children: <Widget>[
            GridView.builder(
                shrinkWrap: true,
                itemCount: colors.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return Container(color: colors[index]);
                }),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 45.0,
                    color: colors[index],
                  );
                },
                separatorBuilder: (context, index) => divider,
                itemCount: colors.length)
          ],
        ));
  }

  static Iterable<Color> getRandomColors() {
    List<Color> list = List();
    Random random = Random();
    for (int i = 0; i < 9; i++) {
      list.add(Color.fromARGB(
          255, random.nextInt(255), random.nextInt(255), random.nextInt(255)));
    }
    return list;
  }
}
