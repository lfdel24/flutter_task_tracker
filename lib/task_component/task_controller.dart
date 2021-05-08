import 'package:flutter/material.dart';
import 'package:task_tracker/task_component/model/task_model.dart';
import 'package:task_tracker/task_component/services/task_service.dart';

class TaskController {
  final service = TaskService();
  final tasksValue = ValueNotifier(<TaskModel>[]);

  Future<void> loadTasks() async {
    this.tasksValue.value = [...await this.service.getAll()];
  }

  Future<void> save(TaskModel task) async {
    this.tasksValue.value = [...this.tasksValue.value, task];
    await this.service.save(this.tasksValue.value);
  }

  Future<void> delete(TaskModel task) async {
    this.tasksValue.value = [
      ...this.tasksValue.value.where((el) => !el.id.contains(task.id))
    ];
    await this.service.save(this.tasksValue.value);
  }

  Future<void> deleteAll() async {
    this.tasksValue.value = [];
    await this.service.save(this.tasksValue.value);
  }
}
