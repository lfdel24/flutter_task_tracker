import 'package:flutter/material.dart';
import 'package:task_tracker/my_value_notifier.dart';
import 'package:task_tracker/task_component/model/task.dart';
import 'package:task_tracker/task_component/services/task_service.dart';

class TaskController {
  final service = TaskService();
  final tasks = MyValueNotifier(<Task>[]);
  var task = MyValueNotifier(Task("$UniqueKey", "", "", false));
  final isLoading = MyValueNotifier(false);
  final opacityLevel = MyValueNotifier(0.0);

  void changeOpacityLevel() {
    this.opacityLevel.value = this.opacityLevel.value == 0 ? 1.0 : 0.0;
  }

  Future<void> loadTasks() async {
    this.isLoading.value = false;
    this.tasks.value = await this.service.getAll();
    this.isLoading.value = true;
  }

  Future<void> save() async {
    this.tasks.value = this.tasks.value..add(this.task.value);
    saveAll();
  }

  Future<void> reminder(Task task) async {
    task.favorite = !task.favorite;
    this.tasks.value = this.tasks.value
      ..forEach((el) {
        if (el.id.contains(task.id)) {
          el = task;
        }
      });
    saveAll();
  }

  Future<void> delete(Task task) async {
    this.tasks.value = this.tasks.value..remove(task);
    await saveAll();
  }

  Future<void> saveAll() async {
    await this.service.save(this.tasks.value);
  }

  Future<void> deleteAll() async {
    this.tasks.value = [];
    await this.service.save(this.tasks.value);
  }
}
