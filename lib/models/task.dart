class Task {
  int? id;
  String title;
  String description;
  bool isCompleted;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
      return Task(
        id: map['id'],
        title: map['title'], 
        description: map['description'],
        isCompleted: map['isCompleted'] == 1,
        );
  }
  Task({required this.title, required this.description, this.isCompleted = false, this.id});
}