import 'package:flutter/material.dart';

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('NewRoute'),
      ),
      body: Center(

        child: Column(
          //Column内容位置
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcom to NewRoute",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.red,
                  backgroundColor: Colors.black38),
            ),
            RaisedButton(
                child: Text('Back'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
