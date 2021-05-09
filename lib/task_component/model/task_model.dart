class TaskModel {
  final String id;
  final String text;
  final String day;
  final bool reminder;

  TaskModel(this.id, this.text, this.day, this.reminder);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      json['id'],
      json['text'],
      json['day'],
      json['reminder'].toString().contains("true"),
    );
  }

  static Map<String, dynamic> toMap(TaskModel task) => {
        'id': task.id,
        'text': task.text,
        'day': task.day,
        'reminder': task.reminder,
      };

  @override
  String toString() {
    return "${this.id}, ${this.text}, ${this.day}, ${this.reminder}";
  }
}
