import 'package:flutter/material.dart';

import 'data.dart';

class PageDataTableDemo1 extends StatefulWidget {
  @override
  _PageDataTableDemoState createState() => _PageDataTableDemoState();
}

class _PageDataTableDemoState extends State<PageDataTableDemo1> {
  List<Item> items = [];
  int _sortColumnIndex = 1;
  bool _sortAscending = true;

  MyDataTableSource dataTableSource;

  @override
  void initState() {
    items = getData();
    items.sort((a, b) {
      return a.age - b.age;
    });
    dataTableSource = MyDataTableSource(items);
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
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: ListView(
          children: <Widget>[
            PaginatedDataTable(
              //每页显示数量，默认10
              rowsPerPage: 11,
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
                        dataTableSource.sort(ascending);
                      });
                    }),
                DataColumn(label: Text('住址')),
                DataColumn(label: Text('头像')),
              ],
              source: dataTableSource,
              header: Text('分页DataTable'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<Item> list;

  MyDataTableSource(this.list);

  int _selectedRowCount = 0;

  @override
  DataRow getRow(int index) {
    final Item item = list[index];
    return DataRow(cells: <DataCell>[
      DataCell(Text('${item.name}')),
      DataCell(Text('${item.age.toString()}')),
      DataCell(Text('${item.address}')),
      DataCell(Image.network(item.img,height: 60.0,width: 60.0))
    ]);
  }

  @override
  //是否不确定行数
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => list.length;

  @override
  int get selectedRowCount => _selectedRowCount;

  void sort(bool ascending) {
    list.sort((a, b) {
      return ascending ? a.age - b.age : b.age - a.age;
    });
    notifyListeners();
  }
}
