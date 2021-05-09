import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_tracker/my_value_notifier.dart';
import 'package:task_tracker/task_component/model/task.dart';
import 'package:task_tracker/task_component/services/task_service.dart';

class TaskController {
  final service = TaskService();
  final tasks = ValueNotifier(<Task>[]);
  var task = MyValueNotifier(Task("$UniqueKey", "", "", false));
  final isLoading = ValueNotifier(false);

  Future<void> loadTasks() async {
    this.isLoading.value = false;
    this.tasks.value = [...await this.service.getAll()];
    // await Future.delayed(Duration(seconds: 3));
    this.isLoading.value = true;
  }

  Future<void> save(Task task) async {
    this.tasks.value = [...this.tasks.value..add(task)];
    saveAll();
  }

  Future<void> reminder(Task task) async {
    this.tasks.value = [
      ...this.tasks.value
        ..forEach((el) {
          if (el.id.contains(task.id)) {
            task.favorite = !task.favorite;
            print(task);
            el = task;
          }
        })
    ];
    saveAll();
  }

  Future<void> delete(Task task) async {
    this.tasks.value = [...this.tasks.value..remove(task)];
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
