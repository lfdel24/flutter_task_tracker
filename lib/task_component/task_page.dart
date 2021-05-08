import 'package:flutter/material.dart';
import 'package:task_tracker/task_component/model/task_model.dart';
import 'package:task_tracker/task_component/my_inherited_widget.dart';
import 'package:task_tracker/task_component/task_controller.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var controller = TaskController();

  @override
  void dispose() {
    super.dispose();
    this.controller = null;
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
    final controller = MyInheritedWidget.of(context).controller;
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
              Text(
                "Task Tracker | lfdel24@gmail.com",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Expanded(child: Container()),
              ValueListenableBuilder(
                valueListenable: controller.tasksValue,
                builder: (_, tasks, __) => Text("${tasks.length} items"),
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
                  await controller.save(TaskModel(
                      "${UniqueKey()}",
                      "${UniqueKey()} ${DateTime.now()}",
                      "${DateTime.now()}",
                      false));
                },
              )
            ],
          ),
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
    final controller = MyInheritedWidget.of(context).controller;
    controller.loadTasks();

    var listView = ValueListenableBuilder(
      valueListenable: controller.tasksValue,
      builder: (_, tasks, __) => Expanded(
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
                        controller.delete(tasks[i]);
                      },
                      icon: Icon(Icons.delete),
                    )
                  ],
                ),
                Text("${tasks[i].text}"),
              ],
            ),
          ),
        ),
      ),
    );

    return ValueListenableBuilder(
      valueListenable: controller.loadValue,
      builder: (_, load, __) => load ? listView : CircularProgressIndicator(),
    );
  }
}
