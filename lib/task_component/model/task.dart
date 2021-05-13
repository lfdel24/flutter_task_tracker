class Task {
  final String id;
  String text;
  String day;
  bool favorite;

  Task(this.id, this.text, this.day, this.favorite);

  String dayFormat() {
    if (this.day.length >= 16) {
      return this.day.substring(2, 16);
    }
    return this.day;
  }

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
