import 'dart:math';

import 'package:flutter/material.dart';

class MyGridView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  final List<Color> colors = [Color(0x00000000)];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView'),
      ),
      body: GridView.builder(
          itemCount: colors.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            //到底底部
            if (colors[index] == Color(0x00000000)) {
              //数据少于100
              if (colors.length < 100) {
                loadData();
                return Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: Text('已没有更多数据了'),
                );
              }
            }
            return Container(
              color: colors[index],
            );
          }),
    );
  }

  void loadData() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        colors.insertAll(colors.length - 1, getRandomColors());
      });
    });
  }

  Iterable<Color> getRandomColors() {
    List<Color> list = List();
    Random random = Random();
    for (int i = 0; i < 20; i++) {
      list.add(Color.fromARGB(
          255, random.nextInt(255), random.nextInt(255), random.nextInt(255)));
    }
    return list;
  }
}
