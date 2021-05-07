import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tracker/task_component/model/task_model.dart';

class TaskService {
  final String _key = "KEY";

  void save(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, json.encode(tasks));
  }

  Future<dynamic> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await json.decode(prefs.getString(_key)) as List;
    return result;
  }
}
