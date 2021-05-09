import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tracker/task_component/model/task.dart';

class TaskService {
  final String _key = "tasks";

  Future<void> save(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _key, json.encode(tasks.map((e) => Task.toMap(e)).toList()));
  }

  Future<List<Task>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(_key);
    if (value == null) {
      return [];
    }
    return (json.decode(value) as List).map((e) => Task.fromJson(e)).toList();
  }
}
