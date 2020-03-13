import 'package:flutter/material.dart';
import '2_base_widget.dart';
import '3_form.dart';
import '4_layout.dart';
import 'package:flutter_app_1/nav/img_list_ui.dart';
import 'package:flutter_app_1/nav/tab_view.dart';
import 'package:flutter_app_1/nav/record_list.dart';

class Ui extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UiState();
}

class UiState extends State<Ui> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  TabController tabController;
  final tabs = ['视频', '图文', 'GIF'];
  final pages = [BaseWidget(), FormSimple(), Layout()];
  List<Widget> navPages;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      print('index=${tabController.index}');
    });
    navPages = [TabViewUi(tabs,tabController), Record(), MainUi(), MainUi()];
  }

  @override
  void dispose() {
    tabController.dispose();
    print('tabController dispose .....');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UI 导航'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () {})
        ],
      ),
      drawer: MyDrawer(),
      body: navPages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('主页')),
          BottomNavigationBarItem(
              icon: Icon(Icons.record_voice_over), title: Text('通讯录')),
          BottomNavigationBarItem(
              icon: Icon(Icons.find_in_page), title: Text('发现')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('个人')),
        ],
        currentIndex: selectedIndex,
        onTap: checkTap,
        fixedColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }

  void checkTap(value) {
    setState(() {
      selectedIndex = value;
    });
  }
}

class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 250.0,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Image.asset(
                    'assets/image/img_head.jpg',
                    width: 80.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                ),
                Text('唐人',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                Text('这个人很懒什么都没留下...', overflow: TextOverflow.ellipsis)
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('设置'),
                leading: Icon(Icons.settings),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('分享'),
                leading: Icon(Icons.share),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}
