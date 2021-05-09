import 'package:flutter/material.dart';
import 'package:task_tracker/task_component/controller/task_controller.dart';

class MyInheritedWidget extends InheritedWidget {
  final Widget child;
  final TaskController controller;

  MyInheritedWidget({required this.child, required this.controller})
      : super(child: child);

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: TaskController);
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw false;
  }
}
