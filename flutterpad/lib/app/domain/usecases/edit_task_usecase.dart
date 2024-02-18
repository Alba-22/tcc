import 'package:flutterpad/app/core/usecases/usecase.dart';
import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/domain/repositories/tasks_repository.dart';

final class EditTaskUsecase extends Usecase<EditTaskDTO, void> {
  final TasksRepository _repository;

  EditTaskUsecase(this._repository);

  @override
  Future<void> call(EditTaskDTO input) {
    final task = TaskEntity(
      id: input.id,
      text: input.text,
      description: input.description,
      date: input.date,
      completed: input.completed,
    );
    return _repository.updateTask(task);
  }
}

typedef EditTaskDTO = ({
  String id,
  String text,
  DateTime date,
  String description,
  bool completed,
});
