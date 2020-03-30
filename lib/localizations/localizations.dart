//多语言

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//提供了本地化值
class MyLocalizations {
  //是否是中文
  bool isZh = false;

  MyLocalizations(this.isZh);

  static MyLocalizations of(BuildContext context) {
    return Localizations.of(context, MyLocalizations);
  }

  String get appTitle{
    return isZh?'Flutter 入门学习':'Flutter Introductory learning';
  }

  String get baseWidgetExampleText {
    return isZh ? '基础组件示例' : 'Basic component example';
  }

  String get layoutWidgetExampleText {
    return isZh ? '布局类组件示例' : 'Layout component example';
  }

  String get containerWidgetExampleText {
    return isZh ? '容器类组件示例' : 'Container component example';
  }

  String get scrollerWidgetExampleText {
    return isZh ? '可滚动组件示例' : 'Scroller component example';
  }
}

//Locale改变时加载新的Locale资源
class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    //是否支持某个locale
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<MyLocalizations> load(Locale locale) {
    //加载locale资源
    print('当前语言：$locale');
    return SynchronousFuture<MyLocalizations>(
        MyLocalizations(locale.languageCode == 'zh'));
  }

  @override
  bool shouldReload(LocalizationsDelegate<MyLocalizations> old) => false;
}
