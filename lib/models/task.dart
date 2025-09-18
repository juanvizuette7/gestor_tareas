class Task {
  final int? id;
  final String title;
  final String description;
  final String date;
  final String status;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    this.status = "pendiente",
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      status: map['status'],
    );
  }
}
