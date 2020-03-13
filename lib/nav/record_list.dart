import 'package:flutter/material.dart';

class Record extends StatelessWidget {
  final List<Person> list = getRecord();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: list.map((person) {
        return Container(
          color: Colors.grey,
          width: double.infinity,
          padding: EdgeInsets.only(top: 10.0, left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${person.name}'),
              Text('${person.phone}'),
              Container(margin: EdgeInsets.only(top: 20.0),)
            ],
          ),
        );
      }).toList(),
    );
  }

  static List<Person> getRecord() {
    Person p1 = Person("张三", '18682188964');
    Person p2 = Person("李四", '15605675925');
    Person p3 = Person("王五", '17058961582');
    Person p4 = Person("赵六", '13256875855');
    Person p5 = Person("陆七", '18698585858');
    Person p6 = Person("颜小八", '13698585008');
    Person p7 = Person("张无忌", '17098585548');
    List<Person> list = List();
    list.add(p1);
    list.add(p2);
    list.add(p3);
    list.add(p4);
    list.add(p5);
    list.add(p6);
    list.add(p7);
    return list;
  }
}

class Person {
  String phone;
  String name;
  String imgPath = "assets/image/img_head.jpg";

  Person(this.phone, this.name);
}
