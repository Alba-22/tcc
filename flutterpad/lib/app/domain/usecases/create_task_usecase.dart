import 'package:flutterpad/app/core/usecases/usecase.dart';
import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/domain/repositories/tasks_repository.dart';
import 'package:uuid/uuid.dart';

final class CreateTaskUsecase extends Usecase<CreateTaskDTO, void> {
  final Uuid _uuid;
  final TasksRepository _repository;

  CreateTaskUsecase(this._uuid, this._repository);

  @override
  Future<void> call(CreateTaskDTO input) {
    final task = TaskEntity(
      id: _uuid.v4(),
      text: input.text,
      description: input.description,
      date: input.date,
      completed: false,
    );
    return _repository.createTask(task);
  }
}

typedef CreateTaskDTO = ({
  String text,
  DateTime date,
  String description,
});
