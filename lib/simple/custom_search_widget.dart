import 'package:flutter/material.dart';

class SearchDemo extends StatefulWidget {
  @override
  _SearchDemoState createState() => _SearchDemoState();
}

class _SearchDemoState extends State<SearchDemo>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索栏'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () =>
                showSearch(context: context, delegate: MySearchDelegate()),
          )
        ],
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate<String> {
  @override
  //最左边的action动作
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear, color: Theme.of(context).primaryColor),
          onPressed: () => query = '')
    ];
  }

  @override
  //back icon
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => close(context, null),
    );
  }

  @override
  //搜索结果点击后的显示
  Widget buildResults(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
      width: double.infinity,
      alignment: Alignment.center,
      child: Card(
        elevation: 4.0,
        clipBehavior: Clip.antiAlias,
        child: Text(query),
      ),
    );
  }



  @override
  Widget buildSuggestions(BuildContext context) {
    final list = testQuery(query);
    if (list.length > 0) {
      return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
          return  RichText(text: TextSpan(children: _keywordTextSpans(list[index],query)));
          });
    }
    return Text('无数据');
  }
}


_keywordTextSpans(String word, String keyword) {
  List<TextSpan> spans = [];
  List<String> arr = word.split(keyword);
  TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
  TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
  for (int i = 0; i < arr.length; i++) {
    if ((i + 1) % 2 == 0) {
      spans.add(TextSpan(text: keyword, style: keywordStyle));
    }
    String val = arr[i];
    if (val != null && val.length > 0) {
      spans.add(TextSpan(text: val, style: normalStyle));
    }
  }
  return spans;
}

List<String> testQuery(String key) {
  List<String> list = [];
  for (String str in datas) {
    if (key.length > 0) {
      a:
      for (int i = 0; i < str.length; i++) {
        b:
        for (int j = 0; j < key.length; j++) {
          if (str[i] == key[j]) {
            list.add(str);
            break a;
            break b;
          }
        }
      }
    }
  }
  return list;
}

const datas = [
  '7喜-可可欧克利',
  '情人节7夕',
  '人生如7',
  '测试77777哈哈',
  '1喜-可可欧克利',
  '情人节1夕',
  '人生如1',
  '测试11111哈哈',
  '9喜-可可欧克利',
  '情人节9夕',
  '人生如9',
  '测试99991哈哈',
];
