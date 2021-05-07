import 'package:flutter/material.dart';
import 'package:task_tracker/task_component/model/task_model.dart';
import 'package:task_tracker/task_component/services/task_service.dart';

class TaskController {
  final vnTasks = ValueNotifier(<TaskModel>[]);

  Future<void> loadTasks() async {
    this.vnTasks.value.addAll(await TaskService().getAll());
  }

  Future<void> save(TaskModel task) async {
    this.vnTasks.value.add(task);
    await TaskService().save(this.vnTasks.value);
  }
}
