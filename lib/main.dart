import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/task_component/task_page.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task Tracker | lfdel24@gmail.com',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskPage(),
    );
  }
}
