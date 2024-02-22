import 'package:flutterpad/app/infra/models/isar_task_model.dart';
import 'package:flutterpad/app/presentation/entities/task_entity.dart';

class IsarTaskMapper {
  static TaskEntity toEntity(IsarTaskModel model) {
    return TaskEntity(
      id: model.taskId,
      text: model.text,
      description: model.description,
      date: model.date,
      completed: model.completion,
    );
  }

  static IsarTaskModel fromEntity(TaskEntity entity) {
    return IsarTaskModel(
      taskId: entity.id,
      text: entity.text,
      description: entity.description,
      date: entity.date,
      completion: entity.completed,
    );
  }
}
