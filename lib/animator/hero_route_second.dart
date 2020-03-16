//测试共享元素

import 'package:flutter/material.dart';

class HeroRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('原图'),
      ),
      body: Hero(
        tag: 'avatar',
        child: Image.asset(
          'assets/image/img_head.jpg',
          width: double.infinity,
          height: 400.0,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
