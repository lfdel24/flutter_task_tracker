import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tracker/task_component/model/task_model.dart';

class TaskService {
  final String _key = "KEY";

  Future<void> save(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _key,
        json.encode(tasks
            .map<Map<String, dynamic>>((task) => TaskModel.toMap(task))
            .toList()));
  }

  Future<List<TaskModel>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(_key);
    return (json.decode(value) as List<dynamic>)
        .map((e) => TaskModel.fromJson(e))
        .toList();
  }
}
