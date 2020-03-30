//官方Demo
import 'package:flutter/material.dart';
import 'package:flutter_app_1/util/toast.dart';

class ExpansionPanelMyDemo extends StatefulWidget {
  @override
  _ExpansionPanelMyDemoState createState() => _ExpansionPanelMyDemoState();
}

class _ExpansionPanelMyDemoState extends State<ExpansionPanelMyDemo> {
  List<Item> _items;
  List<Item> _items2;

  @override
  void initState() {
    _items = items();
    _items2 = items();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('进阶Demo'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
              child: Text('ExpansionPanelList-无法控制_allowOnlyOnePanelOpen'),
            ),
            ExpansionPanelList(
              children: _items.map<ExpansionPanel>((item) {
                print('item  ${item.items.length}');
                return ExpansionPanel(
                    isExpanded: item.isExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(title: Text(item.headTitle));
                    },
                    body: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: item.items.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: ListTile(title: Text(item.items[index])),
                            onTap: () {
                              Toast.toast(context, item.items[index]);
                            },
                          );
                        }));
              }).toList(),
              expansionCallback: (index, isExpanded) {
                setState(() => _items[index].isExpanded = !isExpanded);
              },
            ),
            Container(
              padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
              child: Text('ExpansionPanelList.radio-可控制_allowOnlyOnePanelOpen'),
            ),
            ExpansionPanelList.radio(
              children: _items2.map<ExpansionPanel>((item) {
                //这里也要改为ExpansionPanelRadio
                return ExpansionPanelRadio(
//                    isExpanded: item.isExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(title: Text(item.headTitle));
                    },
                    body: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: item.items.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: ListTile(title: Text(item.items[index])),
                            onTap: () {
                              Toast.toast(context, item.items[index]);
                            },
                          );
                        }),
                    value: item.headTitle);
              }).toList(),
              expansionCallback: (index, isExpanded) {
                setState(() => _items2[index].isExpanded = !isExpanded);
              },
            ),
          ],
        )));
  }

  items() {
    Item item1 =
        Item(headTitle: '开发语言', items: ['Java', 'Flutter', 'Kotlin', 'Gradle']);
    Item item2 = Item(
        headTitle: '四大组件',
        items: ['Activity', 'Service', 'BroadcastReceiver', 'ContentProvider']);
    Item item3 = Item(headTitle: '四大名著', items: ['西游记', '红楼梦', '水浒传', '三国演义']);
    return [item1, item2, item3];
  }
}

class Item {
  String headTitle;
  bool isExpanded;
  List<String> items;

  Item({this.headTitle, this.isExpanded = false, this.items});
}
