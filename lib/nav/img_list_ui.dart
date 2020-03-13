import 'package:flutter/material.dart';

class MainUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        Container(
          width: double.infinity,
          height: 100.0,
          child: Image.network(
            'http://i.gongxiao8.com/uploads/i_2_336338317x148809739_26.jpg',
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        Container(
          width: double.infinity,
          height: 100.0,
          child: Image.network(
            'http://img.jf258.com/i/0a1684686351x2607718101b27.jpg',
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        Container(
          width: double.infinity,
          height: 100.0,
          child: Image.network(
            'http://photo.16pic.com/00/39/87/16pic_3987911_b.jpg',
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        Container(
          width: double.infinity,
          height: 100.0,
          child: Image.network(
            'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1021479086,2570190614&fm=26&gp=0.jpg',
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        Container(
          width: double.infinity,
          height: 100.0,
          child: Image.network(
            'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=974485380,306586106&fm=26&gp=0.jpg',
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        Container(
          width: double.infinity,
          height: 100.0,
          child: Image.network(
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583918082952&di=23734b571a188ec80309aa7f5177998c&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201610%2F12%2F20161012111322_KmtiF.jpeg',
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        Container(
          width: double.infinity,
          height: 100.0,
          child: Image.network(
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583918082951&di=bbf663cde410db9ae6c875d9d83a4abc&imgtype=0&src=http%3A%2F%2Fpic1.16pic.com%2F00%2F56%2F54%2F16pic_5654364_b.jpg',
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        Container(
          width: double.infinity,
          height: 100.0,
          child: Image.network(
            'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3539200818,110614789&fm=26&gp=0.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
