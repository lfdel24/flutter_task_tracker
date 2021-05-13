import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/task_component/controller/task_controller.dart';
import 'package:task_tracker/task_component/model/task.dart';
import 'package:task_tracker/task_component/my_button.dart';
import 'package:task_tracker/task_component/my_circular_p_i.dart';
import 'package:task_tracker/task_component/my_snack_bar.dart';
import 'package:task_tracker/task_component/new_task.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final controller = Get.put(TaskController());

  @override
  void dispose() {
    super.dispose();
    this.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: _BuilderBody(),
      ),
    );
  }
}

class _BuilderBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black)),
      child: Column(
        children: [
          _BuilderAppBar(),
          _BuilderSearchTask(),
          NewTask(),
          _BuilderListView(),
        ],
      ),
    );
  }
}

class _BuilderAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    return Row(
      children: [
        Expanded(
            child: Text(
          "Task Tracker | lfdel24@gmail.com",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        )),
        GetBuilder<TaskController>(
          init: controller,
          builder: (c) => MyIconButton(
              text: "Favorites",
              icon: Icon(c.favorites ? Icons.star : Icons.star_border),
              onPressed: () {
                controller.favorites = !controller.favorites;
                controller.update();
              }),
        ),
        MyIconButton(
            text: "Delete all",
            icon: Icon(Icons.delete),
            onPressed: () async => await controller.deleteAll()),
        SizedBox(width: 4),
        GetBuilder<TaskController>(
            init: controller,
            builder: (c) => MyIconButton(
                text: c.isVisible ? "Close" : "New",
                icon: Icon(c.isVisible ? Icons.close : Icons.add),
                onPressed: () => controller.updateIsVisible()))
      ],
    );
  }
}

class _BuilderSearchTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    return GetBuilder<TaskController>(
      init: controller,
      builder: (c) => Visibility(
          visible: !c.isVisible,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Search task",
                      ),
                      onChanged: (String value) {
                        c.filter = value;
                        c.update();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                children: [
                  Expanded(child: Container()),
                  GetBuilder<TaskController>(
                      init: controller, builder: (c) => Text(c.countItems())),
                ],
              )
            ],
          )),
    );
  }
}

class _BuilderListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    controller.loadTasks();
    return GetBuilder<TaskController>(
        init: controller,
        builder: (c) => c.isLoading
            ? MyCircularPI()
            : _builderListView(context, controller));
  }

  Widget _builderListView(BuildContext context, TaskController controller) {
    return GetBuilder<TaskController>(
      init: controller,
      builder: (c) => Visibility(
        visible: !c.isVisible,
        child: c.tasks.isEmpty
            ? Expanded(
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("0 items")),
              ))
            : Expanded(
                child: ListView.builder(
                  itemCount: c.tasks.length,
                  itemBuilder: (_, i) {
                    Task task = c.tasks[i];
                    if (c.filterTasks(task)) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        margin: EdgeInsets.only(top: 4, left: 4),
                        height: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${task.day}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(child: Container()),
                                IconButton(
                                    onPressed: () {
                                      c.reminder(task);
                                    },
                                    icon: Icon(task.favorite
                                        ? Icons.star
                                        : Icons.star_border)),
                                SizedBox(width: 4),
                                IconButton(
                                  onPressed: () {
                                    c.delete(task);
                                    MySnackBar.show(context, "Item delete");
                                  },
                                  icon: Icon(Icons.delete),
                                )
                              ],
                            ),
                            Text("${task.text}"),
                            Divider(),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
      ),
    );
  }
}
