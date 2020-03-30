//官方Demo
import 'package:flutter/material.dart';

class ExpansionPanelDemo extends StatefulWidget {
  @override
  _ExpansionPanelDemoState createState() => _ExpansionPanelDemoState();
}

class _ExpansionPanelDemoState extends State<ExpansionPanelDemo> {
  List<Item> _data = [];

  @override
  void initState() {
    _data = getItem(4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('官方Demo'),),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (int panelIndex, bool isExpanded) {
            setState(() => _data[panelIndex].isExpanded = !isExpanded);
          },
          children: _data.map<ExpansionPanel>((item) {
            return ExpansionPanel(
                isExpanded: item.isExpanded,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(title: Text(item.headerValue));
                },
                body: ListTile(
                    title: Text(item.expandedValue),
                    subtitle: Text(
                        'To delete this panel, tap the trash can icon'),
                    trailing: Icon(Icons.delete),
                    onTap: () {
                      setState(() {
                        _data.removeWhere((currentItem) => item == currentItem);
                      });
                    }));
          }).toList(),
        ),
      )
    );
  }

  List<Item> getItem(int numberOfItems) {
    return List.generate(numberOfItems, (index) {
      return Item(
          headerValue: 'Panel $index',
          expandedValue: 'This is item number $index');
    }).toList();
  }
}

class Item {
  String expandedValue;
  String headerValue;
  bool isExpanded;

  Item({this.expandedValue, this.headerValue, this.isExpanded = false});
}
