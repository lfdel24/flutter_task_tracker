import 'package:flutter/material.dart';
import 'package:task_tracker/task_component/model/task.dart';
import 'package:task_tracker/task_component/my_inherited_widget.dart';

class NewTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = MyInheritedWidget.of(context)!.controller;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            autofocus: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Task",
            ),
            onChanged: (String value) => controller.task.value.text = value,
          ),
          TextField(
            autofocus: true,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              labelText: "Date",
            ),
            onChanged: (String value) =>
                controller.task.value.day = "${DateTime.now()}",
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
              TextButton(
                  onPressed: () async {
                    await controller.save();
                    controller.changeOpacityLevel();
                  },
                  child: Text("Save")),
              SizedBox(width: 4),
              TextButton(onPressed: () {}, child: Text("Cancel")),
            ],
          ),
        ],
      ),
    );
  }
}
