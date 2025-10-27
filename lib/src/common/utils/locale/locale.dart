import 'package:flutter/material.dart';

class LocaleBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, Locale locale) builder;

  const LocaleBuilder({Key? key, required this.builder}) : super(key: key);

  static _LocaleBuilderState of(BuildContext context) {
    final state = context.findAncestorStateOfType<_LocaleBuilderState>();
    if (state == null) {
      throw Exception('No LocaleBuilder ancestor found');
    }
    return state;
  }

  @override
  _LocaleBuilderState createState() => _LocaleBuilderState();
}

class _LocaleBuilderState extends State<LocaleBuilder> {
  Locale _locale = const Locale('ru'); // задаем язык локализации по умолчанию

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _locale);
  }
}