import 'package:flutter/material.dart';

class MySnackBar {
  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Padding(padding: EdgeInsets.only(left: 4), child: Text(text)),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    ));
  }
}
