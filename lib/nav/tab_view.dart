import 'package:flutter/material.dart';

class TabViewUi extends StatefulWidget {
  final List tabs;
  final TabController tabController;

  TabViewUi(this.tabs, this.tabController);

  @override
  _TabViewUiState createState() => _TabViewUiState();
}

class _TabViewUiState extends State<TabViewUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,//取消返回箭头
        flexibleSpace: SafeArea(//因此toolbar
          child: TabBar(
            tabs: widget.tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
            controller: widget.tabController,
          ),
        ),
      ),
      body: TabBarView(
        controller: widget.tabController,
        children: widget.tabs.map((e) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              e,
              textScaleFactor: 5.0,
            ),
          );
        }).toList(),
      ),
    );
  }
}
