import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class IntlLocalizations {
  static Future<IntlLocalizations> load(Locale locale) {
    print('${locale.languageCode}-${locale.countryCode}-${ locale.toString()}');
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localName = Intl.canonicalizedLocale(name);
    print('name=$name');
    print('localName=$localName');
    return initializeMessages(localName).then((b) {
      print('b=$b');
      Intl.defaultLocale = localName;
      return IntlLocalizations();
    });
  }

  static IntlLocalizations of(BuildContext context) =>
      Localizations.of<IntlLocalizations>(context, IntlLocalizations);

  String get title {
    return Intl.message('Flutter App',
        name: 'title',
        desc: 'Title for the Demo application',
        locale: '_localName');
  }

  String get baseWidgetExampleText{
    return Intl.message('Basic component example',
        name: 'baseWidgetExampleText',
        desc: 'Basic component example',
        locale: '_localName');
  }

  String get layoutWidgetExampleText {
    return Intl.message('Layout component example',
        name: 'layoutWidgetExampleText',
        desc: 'Layout component example',
        locale: '_localName');
  }
}

//代理类
class IntlLocalizationDelegate
    extends LocalizationsDelegate<IntlLocalizations> {
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<IntlLocalizations> load(Locale locale) =>
      IntlLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<IntlLocalizations> old) => false;
}
