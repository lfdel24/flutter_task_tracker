import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tracker/task_component/model/task_model.dart';

class TaskService {
  final String _key = "tasks";

  Future<void> save(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _key, json.encode(tasks.map((e) => TaskModel.toMap(e)).toList()));
  }

  Future<List<TaskModel>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(_key)!;
    return (json.decode(value) as List)
        .map((e) => TaskModel.fromJson(e))
        .toList();
  }
}
