import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _BuilderBody(),
      ),
    );
  }
}

class _BuilderBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 300,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.black,
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Task Tracker",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Expanded(child: Container()),
          ElevatedButton(
            onPressed: () {},
            child: Text("Add"),
          )
        ],
      ),
    );
  }
}
