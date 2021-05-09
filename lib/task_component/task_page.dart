import 'package:flutter/material.dart';
import 'package:task_tracker/task_component/model/task.dart';
import 'package:task_tracker/task_component/my_inherited_widget.dart';
import 'package:task_tracker/task_component/controller/task_controller.dart';
import 'package:task_tracker/task_component/new_task.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var controller = TaskController();

  @override
  void dispose() {
    super.dispose();
    // this.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      controller: this.controller,
      child: Scaffold(
        body: Align(
          alignment: Alignment.topCenter,
          child: _BuilderBody(),
        ),
      ),
    );
  }
}

class _BuilderBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = MyInheritedWidget.of(context)!.controller;
    return Container(
      width: 600,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.black,
      )),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                "Task Tracker | lfdel24@gmail.com",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              )),
              ValueListenableBuilder(
                valueListenable: controller.tasks,
                builder: (_, List<Task> tasks, __) =>
                    Text("${tasks.length} items"),
              ),
              SizedBox(width: 4),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await controller.deleteAll();
                  }),
              SizedBox(width: 4),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  await controller.save(Task(
                      "${UniqueKey()}",
                      "${UniqueKey()} ${DateTime.now()}",
                      "${DateTime.now()}",
                      false));
                },
              )
            ],
          ),
          Divider(),
          SizedBox(height: 16),
          NewTask(),
          SizedBox(height: 16),
          _BuilderListView(),
        ],
      ),
    );
  }
}

class _BuilderListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = MyInheritedWidget.of(context)!.controller;
    controller.loadTasks();

    var listView = ValueListenableBuilder(
      valueListenable: controller.tasks,
      builder: (_, List<Task> tasks, __) => Expanded(
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (_, i) => Container(
            decoration: BoxDecoration(
                color: Colors.grey[150],
                borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.only(top: 4, left: 4),
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${tasks[i].day}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: Container()),
                    IconButton(
                        onPressed: () {
                          controller.reminder(tasks[i]);
                        },
                        icon: Icon(tasks[i].favorite
                            ? Icons.star
                            : Icons.star_border)),
                    SizedBox(width: 4),
                    IconButton(
                      onPressed: () {
                        controller.delete(tasks[i]);
                      },
                      icon: Icon(Icons.delete),
                    )
                  ],
                ),
                Text("${tasks[i].text}"),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );

    return ValueListenableBuilder(
      valueListenable: controller.isLoading,
      builder: (_, bool load, __) =>
          load ? listView : CircularProgressIndicator(),
    );
  }
}
