import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String text;
  final String? description;
  final DateTime date;
  final bool completed;

  const TaskEntity({
    required this.id,
    required this.text,
    this.description,
    required this.date,
    required this.completed,
  });

  @override
  List<Object?> get props => [id, text, description, date, completed];

  @override
  bool get stringify => true;

  TaskEntity copyWith({
    String? id,
    String? text,
    String? description,
    DateTime? date,
    bool? completed,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      description: description ?? this.description,
      date: date ?? this.date,
      completed: completed ?? this.completed,
    );
  }
}
