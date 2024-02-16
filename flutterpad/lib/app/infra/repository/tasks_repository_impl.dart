import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/domain/repositories/tasks_repository.dart';
import 'package:flutterpad/app/infra/datasources/local/tasks_local_datasource.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksLocalDatasource _localDatasource;

  TasksRepositoryImpl(this._localDatasource);

  @override
  Future<List<TaskEntity>> getCompletedTasksInLast24Hours() async {
    return _localDatasource.getCompletedTasksInLast24Hours();
  }

  @override
  Future<List<TaskEntity>> getPendingTasks() async {
    return _localDatasource.getPendingTasks();
  }

  @override
  Future<void> createTask(TaskEntity task) async {
    await _localDatasource.saveTask(task, false);
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await _localDatasource.saveTask(task, false);
  }
}
