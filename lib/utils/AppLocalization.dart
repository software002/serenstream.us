import 'package:flutter/widgets.dart';

class AppLocalization {
  Locale? _locale = const Locale('en');
  var all = [
    const Locale('en'),
  ];

  Locale? get locale => _locale;

  setLocale(Locale locale) async {
    _locale = locale;
  }
}
