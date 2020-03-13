//TODO 如何将颜色字符串转换成Color对象
//Color(0xffdc380d)
//var c='dc380d';
//Color(int.parse(c,radix:16)|0xFF000000);//通过位运算符将Alpha设置为FF
//Color(int.parse(c.radix:16)).withAlpha(255);//通过方法将Alpha设置为FF

//颜色亮度
//实现一个背景颜色和Title可以自定义的导航栏

import 'package:flutter/material.dart';
import '../function/theme_route.dart';

class NavBar extends StatelessWidget {
  final String title;
  final Color color;

  NavBar({Key key, this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 52.0, minWidth: double.infinity),
      decoration: BoxDecoration(color: color, boxShadow: [
        //阴影
        BoxShadow(
            color: Colors.black26, offset: Offset(0, 3), blurRadius: 3 //模糊半径
            )
      ]),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            //根据背景色亮度来确定title颜色
            // color.computeLuminance()数字越大颜色就越浅
            color:
                color.computeLuminance() < 0.5 ? Colors.white : Colors.black),
      ),
      alignment: Alignment.center,
    );
  }
}

class AppBarTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('自定义AppBar'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20.0),
              ),
              NavBar(
                color: Colors.blue,
                title: '标题',
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
              ),
              NavBar(
                color: Colors.white,
                title: '标题',
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
              ),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    constraints: BoxConstraints(
                        minWidth: double.infinity, minHeight: 250.0),
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                              color: Colors.black26, offset: Offset(0, 3.0))
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1584067165&di=ce9fa64fa01447bf0bd7d896c1f543d1&src=http://a3.att.hudong.com/68/61/300000839764127060614318218_950.jpg'))),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ThemeTestRoute()));
                },
              )
            ],
          ),
        ));
  }
}
