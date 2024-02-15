import 'package:isar/isar.dart';

part 'isar_task_model.g.dart';

@collection
class IsarTaskModel {
  Id id = Isar.autoIncrement;

  String taskId;
  String text;
  String? description;
  DateTime date;
  bool completion;
  DateTime? syncDate;

  IsarTaskModel({
    required this.taskId,
    required this.text,
    required this.description,
    required this.date,
    required this.completion,
    this.syncDate,
  });
}
