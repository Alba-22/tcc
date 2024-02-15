import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/domain/repositories/tasks_repository.dart';
import 'package:flutterpad/app/infra/datasources/local/tasks_local_datasource.dart';
import 'package:flutterpad/app/infra/datasources/remote/tasks_remote_datasource.dart';
import 'package:flutterpad/app/infra/services/network_checker/network_checker.dart';

class TasksRepositoryImpl implements TasksRepository {
  final NetworkChecker _networkChecker;
  final TasksRemoteDatasource _remoteDatasource;
  final TasksLocalDatasource _localDatasource;

  TasksRepositoryImpl(this._networkChecker, this._remoteDatasource, this._localDatasource);

  @override
  Future<List<TaskEntity>> getCompletedTasksInLast24Hours() async {
    if (await _networkChecker.isConnected) {
      return _remoteDatasource.getCompletedTasksInLast24Hours();
    } else {
      return _localDatasource.getCompletedTasksInLast24Hours();
    }
  }

  @override
  Future<List<TaskEntity>> getPendingTasks() async {
    if (await _networkChecker.isConnected) {
      return _remoteDatasource.getPendingTasks();
    } else {
      return _localDatasource.getPendingTasks();
    }
  }

  @override
  Future<TaskEntity?> getTaskById(String id) {
    return _localDatasource.getTaskById(id);
  }

  @override
  Future<void> createTask(TaskEntity task) async {
    await _localDatasource.saveTask(task, false);
    if (await _networkChecker.isConnected) {
      // DELETAR TASK COM ID ANTIGO
      final id = await _remoteDatasource.createTask(task);
      task = task.copyWith(
        id: id,
      );
      await _localDatasource.saveTask(task, true);
    }
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await _localDatasource.saveTask(task, false);
    if (await _networkChecker.isConnected) {
      await _remoteDatasource.updateTask(task);
      await _localDatasource.saveTask(task, true);
    }
  }
}
