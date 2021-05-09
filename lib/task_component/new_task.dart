import 'package:flutter/material.dart';
import 'package:task_tracker/task_component/model/task.dart';
import 'package:task_tracker/task_component/my_inherited_widget.dart';

class NewTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = MyInheritedWidget.of(context)!.controller;
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              autofocus: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Task",
              ),
            ),
            TextField(
              autofocus: true,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: "Date",
              ),
            ),
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: controller.task,
                  builder: (_, Task task, __) => Checkbox(
                      value: task.favorite,
                      onChanged: (bool? newValue) {
                        task.favorite = !task.favorite;
                        controller.task.value = task;
                      }),
                ),
                SizedBox(width: 4),
                Text("Favorite"),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                TextButton(onPressed: () {}, child: Text("Save")),
                SizedBox(width: 4),
                TextButton(onPressed: () {}, child: Text("Cancel")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
