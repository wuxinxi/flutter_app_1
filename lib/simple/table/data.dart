import 'dart:math';

class Item {
  String name;
  int age;
  String address;
  String img;
  bool selected;

  Item(this.name, this.age, this.address, this.img,{this.selected=false});
}

Random random = Random();

List<Item> getData() {
  List<Item> list = [];
  for (int i = 0; i < 23; i++) {
    Item item = Item('张$i', random.nextInt(30) + 1, '安徽省亳州市谯城区',
        'http://www.xxstudy.cn/static/images/avatar_15.png');
    list.add(item);
  }
  return list;
}
