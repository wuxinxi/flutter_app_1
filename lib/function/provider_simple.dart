import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_1/function/provider_moel.dart';
import '../function/provider_util.dart';

class ProviderRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute> {
  Random random = new Random();

//  List<Item> items = [];

  @override
  Widget build(BuildContext context) {
    Divider divider = Divider(color: Colors.green, height: 1.5);
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: Center(
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(
            builder: (context) {
              return Column(
                children: <Widget>[
                  Builder(
                    builder: (context) {
                      var cart = ChangeNotifierProvider.of<CartModel>(context);
                      print('总计：${cart.totalPrice},${cart.getItemsLength()}');
//                      return Text('总价：${cart.totalPrice}');
                      List<Item> items = cart.getItems();
                      return Container(
                        height: 500.0,
                        child: ListView.separated(
                            itemBuilder: (context, index) => Container(
                                  width: double.infinity,
                                  height: 25.0,
                                  child: Row(
                                    children: <Widget>[
                                      Text('单价：${items[index].price}'),
                                      Container(
                                        margin: EdgeInsets.only(left: 20.0),
                                      ),
                                      Text('数量：${items[index].count}'),
                                      Container(
                                        margin: EdgeInsets.only(left: 20.0),
                                      ),
                                      Text(
                                          '小计：${items[index].price * items[index].count}'),
                                    ],
                                  ),
                                ),
                            separatorBuilder: (context, index) => divider,
                            itemCount: items.length),
                      );
                    },
                  ),
//                  Builder(
//                    builder: (context) {
//                      var cart = ChangeNotifierProvider.of<CartModel>(context);
//                      return Text('总价：${cart.totalPrice}');
//                    },
//                  ),
                  Consumer<CartModel>(
                      builder: (context, cart) =>
                          Text('总价：${cart.totalPrice}')),
                  Builder(
                    builder: (context) {
                      print('构建 RaisedButton');
                      return RaisedButton(
                        onPressed: () {
                          double prices = random.nextInt(100) + 1.toDouble();
                          int count = random.nextInt(10) + 1;
                          //listen=false，此时RaisedButton只会被build一次
                          ChangeNotifierProvider.of<CartModel>(context,
                                  listen: false)
                              .add(Item(prices, count));
                        },
                        child: Text('添加商品'),
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

//显式调用 ChangeNotifierProvider.of时如果有多个model依赖时，显然代码冗余
class Consumer<T> extends StatelessWidget {
  final Widget child;
  final Widget Function(BuildContext context, T value) builder;

  Consumer({Key key, this.child, @required this.builder});

  @override
  Widget build(BuildContext context) =>
      builder(context, ChangeNotifierProvider.of<T>(context));
}
