import 'package:flutter/material.dart';

class MyCPI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: EdgeInsets.only(top: 8), child: CircularProgressIndicator()),
    );
  }
}
