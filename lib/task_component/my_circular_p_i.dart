import 'package:flutter/material.dart';

class MyCircularPI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: EdgeInsets.only(top: 8), child: CircularProgressIndicator()),
    );
  }
}
