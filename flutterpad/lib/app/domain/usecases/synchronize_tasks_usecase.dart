import 'package:flutterpad/app/core/usecases/usecase.dart';
import 'package:flutterpad/app/domain/repositories/tasks_repository.dart';

final class SynchronizeTasksUsecase extends Usecase<void, void> {
  final TasksRepository _repository;

  SynchronizeTasksUsecase(this._repository);

  @override
  Future<void> call(void input) {
    return _repository.synchronizeTasks();
  }
}
