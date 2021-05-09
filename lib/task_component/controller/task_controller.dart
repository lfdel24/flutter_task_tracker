import 'package:flutter/foundation.dart';
import 'package:task_tracker/task_component/model/task_model.dart';
import 'package:task_tracker/task_component/services/task_service.dart';

class TaskController {
  final service = TaskService();
  final tasksValue = ValueNotifier(<TaskModel>[]);
  final loadValue = ValueNotifier(false);

  Future<void> loadTasks() async {
    this.loadValue.value = false;
    this.tasksValue.value = [...await this.service.getAll()];
    await Future.delayed(Duration(seconds: 1));
    this.loadValue.value = true;
  }

  Future<void> save(TaskModel task) async {
    this.tasksValue.value = [...this.tasksValue.value..add(task)];
    saveAll();
  }

  Future<void> reminder(TaskModel task) async {
    this.tasksValue.value = [
      ...this.tasksValue.value
        ..forEach((el) {
          if (el.id.contains(task.id)) {
            task.reminder = !task.reminder;
            print(task);
            el = task;
          }
        })
    ];
    saveAll();
  }

  Future<void> delete(TaskModel task) async {
    this.tasksValue.value = [...this.tasksValue.value..remove(task)];
    await saveAll();
  }

  Future<void> saveAll() async {
    await this.service.save(this.tasksValue.value);
  }

  Future<void> deleteAll() async {
    this.tasksValue.value = [];
    await this.service.save(this.tasksValue.value);
  }
}
