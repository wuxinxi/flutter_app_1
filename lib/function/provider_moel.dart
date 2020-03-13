import 'dart:collection';

import 'package:flutter/material.dart';

class Item {
  double price;
  int count;

  Item(this.price, this.count);
}

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  //禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(items);

  //购物车总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  //将商品添加到购物车中，唯一途径
  void add(item) {
    _items.add(item);
    //通知监听器
    notifyListeners();
  }

  int getItemsLength() => _items.length;

  List<Item> getItems() => _items;
}
