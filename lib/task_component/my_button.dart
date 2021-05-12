import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback? onPressed;

  const MyIconButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        children: [
          IconButton(
            icon: icon,
            onPressed: onPressed,
          ),
          // SizedBox(height: 2),
          Text(
            this.text,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
