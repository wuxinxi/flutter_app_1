import 'package:flutter/material.dart';
import 'package:flutter_app_1/simple/chip.dart';
import 'package:flutter_app_1/simple/custom_search_widget.dart';
import 'package:flutter_app_1/simple/frosted_glass.dart';
import 'package:flutter_app_1/simple/expansionpanel/state_expandsion.dart';
import 'package:flutter_app_1/simple/table/data_tab.dart';

import 'simple/step/setp.dart';

class SimpleDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('实例Demo'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text('毛玻璃效果'),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => FrostedGlassDemo())),
          ),
          FlatButton(
            child: Text('二级展开'),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ExpansionDemo())),
          ),
          FlatButton(
            child: Text('搜索栏'),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchDemo())),
          ),
          FlatButton(
            child: Text('Chip-小碎片 Wrap-换行 Divider-分隔符'),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChipDemo())),
          ),
          FlatButton(
            child: Text('DataTable'),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => DataTableDemo1())),
          ),
          FlatButton(
            child: Text('Step 小部件'),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => StepDemo())),
          ),
        ],
      ),
    );
  }
}
