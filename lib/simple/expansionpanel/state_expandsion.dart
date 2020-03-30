import 'package:flutter/material.dart';

import 'expansionpanel_custom_demo.dart';
import 'expansionpanel_official_demo.dart';

class ExpansionDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('二级展开'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ExpansionTile(
                title: Text('二级目录-可展开'),
                backgroundColor: Colors.pinkAccent,
                leading: Icon(Icons.pages),
                children: <Widget>[
                  ListView.builder(
                    //ExpansionTile是一个无边界容器，因此需要给定true
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        ListTile(title: Text('${index.toString()}')),
                    itemCount: 5,
                  ),
                ],
              ),
             FlatButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> ExpansionPanelDemo()));
             }, child: Text('官方Demo')), FlatButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ExpansionPanelMyDemo()));
              }, child: Text('进阶Demo')),
            ],
          ),
        ));
  }
}

