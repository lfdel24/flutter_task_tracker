import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/task_component/model/task.dart';
import 'package:task_tracker/task_component/my_snack_bar.dart';
import 'package:task_tracker/task_component/services/task_service.dart';

class TaskController extends GetxController {
  final service = TaskService();
  List<Task> tasks = <Task>[];
  Task task = Task("${UniqueKey()}", "", "", false);
  bool isVisible = false;
  String search = "";
  bool isLoading = false;
  String filter = "";
  bool favorites = false;

  String countItems() {
    int favorites = this.tasks.where((el) => el.favorite).length;
    return "${this.tasks.length} items / $favorites favorites";
  }

  bool filterTasks(Task task) {
    return task.text.toLowerCase().contains(filter.toLowerCase()) &&
        (favorites == false || task.favorite == true);
  }

  void updateIsVisible() {
    this.isVisible = !this.isVisible;
    update();
  }

  Future<void> loadTasks() async {
    this.isLoading = true;
    this.tasks = await this.service.getAll();
    await Future.delayed(Duration(seconds: 1));
    this.isLoading = false;
    update();
  }

  Future<void> save(BuildContext context) async {
    if (isValidTask().isNotEmpty) {
      MySnackBar.show(context, isValidTask());
    } else {
      this.tasks.add(this.task);
      this.task = Task("${UniqueKey()}", "", "", false);
      _saveAll();
      update();
      updateIsVisible();
      MySnackBar.show(context, "Tash saved");
    }
  }

  String isValidTask() {
    String message = "";
    bool isValid = true;
    if (this.task.text.isEmpty) {
      message = "The Text is required";
      isValid = false;
    }
    return message;
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
