class Task {
  final String id;
  final String text;
  final String day;
  bool favorite;

  Task(this.id, this.text, this.day, this.favorite);

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['id'],
      json['text'],
      json['day'],
      json['favorite'],
    );
  }

  static Map<String, dynamic> toMap(Task task) => {
        'id': task.id,
        'text': task.text,
        'day': task.day,
        'favorite': task.favorite,
      };

  @override
  String toString() {
    return "${this.id}, ${this.text}, ${this.day}, ${this.favorite}";
  }
}
