import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedGlassDemo extends StatelessWidget {
  var url =
      'http://www.bdluntan.com/d/file/chanpinsheji/2017-02-05/097c8905fe55d084dc16a71f7178e106.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('毛玻璃效果'),
        ),
        body: Center(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.network(
                url,
                fit: BoxFit.fill,
              ),
              ClipRect(
                child: BackdropFilter(
                    child: Opacity(
                      //必须要有透明度
                      opacity: 0.5,
                      child: Container(
                        width: 500,
                        height: 700,
                        alignment: Alignment.center,
                        child: Text('唐人',style: Theme.of(context).textTheme.display3,),
                        color: Colors.grey.shade300,
                      ),
                    ),
                    //过滤器：模糊效果
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0)),
              )
            ],
          ),
        ));
  }
}
