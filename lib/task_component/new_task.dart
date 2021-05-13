import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/task_controller.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final textController = TextEditingController(text: "");
  final dateController = TextEditingController(text: "${DateTime.now()}");

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    return GetBuilder<TaskController>(
      init: controller,
      builder: (c) => Visibility(
        visible: c.isVisible,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                autofocus: true,
                controller: textController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Task",
                ),
              ),
              TextField(
                autofocus: true,
                controller: dateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: "Date and time ",
                ),
              ),
              Row(
                children: [
                  GetBuilder<TaskController>(
                      builder: (c) => Checkbox(
                          value: c.task.favorite,
                          onChanged: (bool? value) {
                            controller.task.favorite = value!;
                            controller.update();
                          })),
                  SizedBox(width: 4),
                  Text("Favorite"),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  TextButton(
                      onPressed: () async {
                        controller.task.text = textController.text;
                        controller.task.day = dateController.text;
                        textController.text = "";
                        dateController.text = "${DateTime.now()}";
                        await controller.save(context);
                      },
                      child: Text("Save")),
                  SizedBox(width: 4),
                  TextButton(onPressed: () {}, child: Text("Cancel")),
                ],
              ),
              SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
