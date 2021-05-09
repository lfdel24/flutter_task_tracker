import 'package:flutter/material.dart';
import 'package:task_tracker/task_component/model/task_model.dart';
import 'package:task_tracker/task_component/services/task_service.dart';

class TaskController {
  final service = TaskService();
  final tasksValue = ValueNotifier(<TaskModel>[]);
  final loadValue = ValueNotifier(false);

  Future<void> loadTasks() async {
    this.loadValue.value = false;
    this.tasksValue.value = [...await this.service.getAll()];
    //TODO: Espera 3 segundos
    await Future.delayed(Duration(seconds: 1));
    this.loadValue.value = true;
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
