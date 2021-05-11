import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/task_component/controller/task_controller.dart';
import 'package:task_tracker/task_component/my_circular_p_i.dart';
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
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
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
            init: controller, builder: (c) => Text("${c.tasks.length} items")),
        SizedBox(width: 4),
        IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async => await controller.deleteAll()),
        SizedBox(width: 4),
        IconButton(
            onPressed: () => controller.updateIsVisible(),
            icon: GetBuilder<TaskController>(
              init: controller,
              builder: (c) => Icon(c.isVisible ? Icons.close : Icons.add),
            )),
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
          child: Container(
            child: Row(
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
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
              ],
            ),
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
        builder: (c) => c.isLoading ? MyCPI() : _builderListView(controller));
  }

  Widget _builderListView(TaskController controller) {
    return GetBuilder<TaskController>(
      init: controller,
      builder: (c) => Visibility(
        visible: !c.isVisible,
        child: c.tasks.isEmpty
            ? Expanded(
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("0 items"),
              ))
            : Expanded(
                child: ListView.builder(
                  itemCount: c.tasks.length,
                  itemBuilder: (_, i) {
                    if (c.tasks[i].text
                        .toLowerCase()
                        .contains(c.filter.toLowerCase())) {
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
                                  "${c.tasks[i].day}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(child: Container()),
                                IconButton(
                                    onPressed: () {
                                      c.reminder(c.tasks[i]);
                                    },
                                    icon: Icon(c.tasks[i].favorite
                                        ? Icons.star
                                        : Icons.star_border)),
                                SizedBox(width: 4),
                                IconButton(
                                  onPressed: () {
                                    c.delete(c.tasks[i]);
                                  },
                                  icon: Icon(Icons.delete),
                                )
                              ],
                            ),
                            Text("${c.tasks[i].text}"),
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
