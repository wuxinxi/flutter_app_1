import 'package:flutter/material.dart';

class MyStateDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyStateDialogSate();
}

class MyStateDialogSate extends State<MyStateDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('状态Dialog'),
      ),
    );
  }
}
