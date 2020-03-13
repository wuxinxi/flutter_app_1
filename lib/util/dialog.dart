import 'package:flutter/material.dart';

void showTip(BuildContext context, String content) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text('提示'),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]);
      });
}
