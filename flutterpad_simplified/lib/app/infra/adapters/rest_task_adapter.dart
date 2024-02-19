import 'package:flutterpad/app/presentation/entities/task_entity.dart';

class RestTaskAdapter {
  static Map<String, dynamic> toMap(TaskEntity task) {
    return {
      "title": task.text,
      "done": task.completed,
      "description": task.description,
      "date": task.date.toIso8601String(),
    };
  }

  static TaskEntity fromMap(Map<String, dynamic> map) {
    return TaskEntity(
      id: map["id"],
      text: map["title"],
      description: map["description"],
      date: DateTime.parse(map["date"]),
      completed: map["done"],
    );
  }
}
