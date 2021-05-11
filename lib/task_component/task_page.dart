import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/task_component/controller/task_controller.dart';
import 'package:task_tracker/task_component/new_task.dart';

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(TaskController());

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
    final controller = Get.find<TaskController>();
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
          _BuilderAppBar(),
          Divider(),
          // _BuilderSearchTask(),

          GetBuilder<TaskController>(
            init: controller,
            builder: (c) => Visibility(
              visible: c.isVisible,
              child: NewTask(),
            ),
          ),
          SizedBox(height: 6),
          Expanded(child: _BuilderListView()),
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

// class _BuilderSearchTask extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final controller = context.read<TaskController>();
//     return Container(
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               autofocus: true,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 labelText: "Search task",
//               ),
//               onChanged: (String value) => controller.searchTask(value),
//             ),
//           ),
//           IconButton(icon: Icon(Icons.search), onPressed: () {}),
//         ],
//       ),
//     );
//   }
// }

class _BuilderListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    controller.loadTasks();
    return GetBuilder<TaskController>(
        init: controller,
        builder: (c) => c.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _builderListView(controller));
  }

  Widget _builderListView(TaskController c) {
    return c.tasks.isEmpty
        ? Text("0 items")
        : ListView.builder(
            itemCount: c.tasks.length,
            itemBuilder: (_, i) => Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
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
                            fontSize: 16, fontWeight: FontWeight.bold),
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
            ),
          );
  }
}
