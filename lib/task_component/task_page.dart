import 'package:flutter/material.dart';
import 'package:task_tracker/task_component/model/task_model.dart';
import 'package:task_tracker/task_component/task_controller.dart';

class TaskPage extends StatelessWidget {
  void load() async {
    final controller = TaskController();
    controller.save(TaskModel("1", "Mi tarea", "${DateTime.now()}", false));
    await controller.loadTasks();
    print("Mis tareas: ${controller.vnTasks.value.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    //
    load();
    //
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
          border: Border.all(
        color: Colors.black,
      )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Tracker",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
              ElevatedButton(
                onPressed: () {},
                child: Text("Add"),
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
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, i) => Container(
          decoration: BoxDecoration(
              color: Colors.grey[299], borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.only(top: 4),
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "aljsdasdasjdoajsd",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                  )
                ],
              ),
              Text("aljsdasdasjdoajsdapḱedpjefdqwepqpoekqopweqpokwekop"),
            ],
          ),
        ),
      ),
    );
  }
}
