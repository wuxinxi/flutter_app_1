import 'package:flutter/material.dart';

import 'data.dart';
import 'page_data_tab.dart';

class DataTableDemo1 extends StatefulWidget {
  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo1> {
  List<Item> items = [];
  int _sortColumnIndex = 1;
  bool _sortAscending = true;

  @override
  void initState() {
    items = getData();
    items.sort((a, b) {
      return a.age - b.age;
    });
    super.initState();
  }

  _delete() {
    setState(() => items.removeWhere((item) => item.selected));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DataTable'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete_forever), onPressed: _delete),
          IconButton(
              icon: Icon(Icons.code),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PageDataTableDemo1()))),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: ListView(
          children: <Widget>[
            DataTable(
                //需要排序的那一栏
                sortColumnIndex: _sortColumnIndex,
                //排序方式：true升序，false降序
                sortAscending: _sortAscending,
                columns: [
                  DataColumn(label: Text('姓名')),
                  DataColumn(
                      label: Text('年龄'),
                      onSort: (columnIndex, ascending) {
                        setState(() {
                          _sortColumnIndex = columnIndex;
                          _sortAscending = ascending;
                          items.sort((a, b) {
                            return ascending ? a.age - b.age : b.age - a.age;
                          });
                        });
                      }),
                  DataColumn(label: Text('住址')),
                  DataColumn(label: Text('头像')),
                ],
                rows: items.map((item) {
                  return DataRow(
                      //添加选择框
                      selected: item.selected,
                      onSelectChanged: (selected) {
                        if (item.selected != selected) {
                          setState(() {
                            item.selected = selected;
                          });
                        }
                      },
                      cells: <DataCell>[
                        DataCell(Text('${item.name}')),
                        DataCell(Text('${item.age.toString()}')),
                        DataCell(Text('${item.address}')),
                        DataCell(Image.network(item.img))
                      ]);
                }).toList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => setState(() => items = getData())),
    );
  }
}
