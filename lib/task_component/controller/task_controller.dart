import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/task_component/model/task.dart';
import 'package:task_tracker/task_component/services/task_service.dart';

class TaskController extends GetxController {
  var service = TaskService();
  var tasks = <Task>[].reactive;
  var task = Task("${UniqueKey()}", "", "", false).reactive;
  bool isVisible = false;
  var search = "".reactive;
  var isLoading = false.reactive;

  void updateIsVisible() {
    this.isVisible = !this.isVisible;
    update();
  }

  void searchTask(String value) {
    // if (value.isEmpty) {
    //   return;
    // }
    // for (var item in this.tasks.value) {
    //   if (item.text.contains(value)) {
    //     print(item);
    //   }
    // }
  }

  Future<void> loadTasks() async {
    this.isLoading.value = true;
    this.tasks.value = await this.service.getAll();
    this.isLoading.value = false;
  }

  Future<void> save() async {
    this.tasks.value!.add(this.task.value!);
    saveAll();
  }

  Future<void> reminder(Task task) async {
    task.favorite = !task.favorite;
    // this.tasks.value = this.tasks.value
    //   ..forEach((el) {
    //     if (el.id.contains(task.id)) {
    //       el = task;
    //     }
    //   });
    saveAll();
  }

  Future<void> delete(Task task) async {
    this.tasks.value!.remove(task);
    await saveAll();
  }

  Future<void> saveAll() async {
    await this.service.save(this.tasks.value!);
  }

  Future<void> deleteAll() async {
    this.tasks.value = [];
    await this.service.save(this.tasks.value!);
  }
}
