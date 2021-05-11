import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/task_component/model/task.dart';
import 'package:task_tracker/task_component/services/task_service.dart';

class TaskController extends GetxController {
  final service = TaskService();
  List<Task> tasks = <Task>[];
  Task task = Task("${UniqueKey()}", "", "", false);
  bool isVisible = false;
  String search = "";
  bool isLoading = false;
  String filter = "";

  void updateIsVisible() {
    this.isVisible = !this.isVisible;
    update();
  }

  Future<void> loadTasks() async {
    this.isLoading = true;
    this.tasks = await this.service.getAll();
    await Future.delayed(Duration(seconds: 3));
    this.isLoading = false;
    update();
  }

  Future<void> save() async {
    this.tasks.add(this.task);
    this.task = Task("${UniqueKey()}", "", "", false);
    _saveAll();
    update();
  }

  Future<void> reminder(Task task) async {
    task.favorite = !task.favorite;
    _saveAll();
    update();
  }

  Future<void> delete(Task task) async {
    this.tasks.remove(task);
    await _saveAll();
    update();
  }

  Future<void> deleteAll() async {
    this.tasks = [];
    await this.service.save(this.tasks);
    update();
  }

  Future<void> _saveAll() async {
    await this.service.save(this.tasks);
  }
}
