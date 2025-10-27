import 'package:flutter/material.dart';

class AppNavigator {
  static push({page, context}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static pop({context}) {
    Navigator.pop(context);
  }

  static pushAndRemove({context, page}) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
            (Route<dynamic> route) => false);
  }
}

