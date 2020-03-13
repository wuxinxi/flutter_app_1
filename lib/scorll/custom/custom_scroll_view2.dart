import 'dart:math';

import 'package:flutter/material.dart';

/// 显然这个时候是不行的，这个时候就需要CustomScrollView
class AddScrollView2 extends StatelessWidget {
  final List<Color> colors = getRandomColors();

  @override
  Widget build(BuildContext context) {
    Divider divider = Divider(
      color: Colors.white,
      height: 8.0,
    );
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            //将始终渲染一个固定在顶部的收起状态组件。
            floating: true,
            //，即使当前CustomScrollView不在顶部，SliverAppBar也会跟着一起向下出现
            snap: false,
            //当手指放开时，SliverAppBar会根据当前的位置进行调整，始终保持展开或收起的状态
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('CustomScrollView'),
              background: Container(
                color: Colors.green,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Container(
                    color: colors[index],
                  );
                }, childCount: colors.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0)),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Text(
                      colors[index].toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    color: colors[index],
                  ),
                  divider
                ],
              );
            }, childCount: colors.length)),
          )
        ],
      ),
    );
  }

  static Iterable<Color> getRandomColors() {
    List<Color> list = List();
    Random random = Random();
    for (int i = 0; i < 12; i++) {
      list.add(Color.fromARGB(
          255, random.nextInt(255), random.nextInt(255), random.nextInt(255)));
    }
    return list;
  }
}
