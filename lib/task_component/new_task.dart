import 'package:flutter/material.dart';

class NewTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.black,
    ));
    //   final controller = context.read<TaskController>();
    //   return Container(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         TextField(
    //           autofocus: true,
    //           keyboardType: TextInputType.text,
    //           decoration: InputDecoration(
    //             labelText: "Task",
    //           ),
    //           onChanged: (String value) => controller.task.text = value,
    //         ),
    //         TextField(
    //           autofocus: true,
    //           keyboardType: TextInputType.datetime,
    //           decoration: InputDecoration(
    //             labelText: "Date",
    //           ),
    //           onChanged: (String value) =>
    //               controller.task.day = "${DateTime.now()}",
    //         ),
    //         Row(
    //           children: [
    //             Checkbox(
    //                 value: controller.task.favorite,
    //                 onChanged: (bool? newValue) {
    //                   //TODO:
    //                 }),
    //             SizedBox(width: 4),
    //             Text("Favorite"),
    //           ],
    //         ),
    //         SizedBox(height: 8),
    //         Row(
    //           children: [
    //             TextButton(
    //                 onPressed: () async {
    //                   await controller.save();
    //                   controller.changeOpacityLevel();
    //                 },
    //                 child: Text("Save")),
    //             SizedBox(width: 4),
    //             TextButton(onPressed: () {}, child: Text("Cancel")),
    //           ],
    //         ),
    //       ],
    //     ),
    //   );
  }
}
