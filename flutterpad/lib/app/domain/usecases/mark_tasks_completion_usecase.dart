import 'package:flutterpad/app/core/usecases/usecase.dart';
import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/domain/errors/task_not_found_failure.dart';
import 'package:flutterpad/app/domain/repositories/tasks_repository.dart';

final class MarkTasksCompletionUsecase extends Usecase<TaskCompletionParams, void> {
  final TasksRepository _repository;

  MarkTasksCompletionUsecase(this._repository);

  @override
  Future<void> call(TaskCompletionParams input) async {
    TaskEntity? task = await _repository.getTaskById(input.task.id);
    if (task == null) {
      throw TaskNotFoundFailure();
    }
    task = task.markTaskCompletion(input.completion);
    await _repository.updateTask(task);
  }
}

typedef TaskCompletionParams = ({
  TaskEntity task,
  bool completion,
});
