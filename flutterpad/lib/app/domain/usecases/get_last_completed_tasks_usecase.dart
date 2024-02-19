import 'package:flutterpad/app/core/usecases/usecase.dart';
import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/domain/repositories/tasks_repository.dart';

final class GetLastCompletedTasksUsecase extends Usecase<void, List<TaskEntity>> {
  final TasksRepository _repository;

  GetLastCompletedTasksUsecase(this._repository);

  @override
  Future<List<TaskEntity>> call(void input) {
    return _repository.getCompletedTasksInLastMonth();
  }
}
