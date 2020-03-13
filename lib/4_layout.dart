import 'package:flutter/material.dart';
import 'util/dialog.dart';

class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('布局类组件实例'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10.0),
              ),
              Text('Flex 弹性布局',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '我占了1/2',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        color: Colors.black,
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '我占了1/2',
                          style:
                              TextStyle(fontSize: 18.0, color: Colors.yellow),
                        ),
                        color: Colors.grey,
                      )),
                ],
              ),
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.red,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(3.0),
                        alignment: Alignment.center,
                        child: Text('我占据了3/1',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white)),
                        color: Colors.blueAccent[100],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(3.0),
                        alignment: Alignment.center,
                        child: Text('我占据了3/1',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white)),
                        color: Colors.blueAccent[400],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(3.0),
                        alignment: Alignment.center,
                        child: Text('我占据了3/1',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white)),
                        color: Colors.blueAccent[700],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
              ),
              Container(
                  width: double.infinity, height: 1.0, color: Colors.grey),
              Text('流式布局',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
              WrapLayout(),
              WrapLayout(),
              WrapLayout(),
              Container(
                margin: EdgeInsets.only(top: 10.0),
              ),
              Container(
                  width: double.infinity, height: 1.0, color: Colors.grey),
              Text('定位布局',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
              AlignAndStackLayout(),
            ],
          ),
        ));
  }
}

/// 流式布局
class WrapLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.0, //水平间距
      runSpacing: 3.0, //垂直间距
      alignment: WrapAlignment.start,
      children: <Widget>[
        ActionChip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
          label: Text('Android'),
          onPressed: () {
            showTip(context, 'Android');
          },
        ),
        ActionChip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('P')),
          label: Text('Python'),
          onPressed: () {
            showTip(context, 'Python');
          },
        ),
        ActionChip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('C')),
          label: Text('C++/C#'),
          onPressed: () {
            showTip(context, 'C++/C#');
          },
        ),
        ActionChip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
          label: Text('Java/JavaScript'),
          onPressed: () {
            showTip(context, 'Java/JavaScript');
          },
        )
      ],
    );
  }
}

//Align/Stack
class AlignAndStackLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150.0,
        height: 150.0,
        color: Colors.green,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/image/img_head.jpg',
                width: 50.0,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                'assets/image/img_head.jpg',
                width: 50.0,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                'assets/image/img_head.jpg',
                width: 50.0,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                'assets/image/img_head.jpg',
                width: 50.0,
              ),
            ),
          ],
        ));
  }
}
