import 'package:flutterpad/app/infra/adapters/isar_task_adapter.dart';
import 'package:flutterpad/app/infra/datasources/local/tasks_local_datasource.dart';
import 'package:flutterpad/app/infra/datasources/remote/tasks_remote_datasource.dart';
import 'package:flutterpad/app/infra/services/network_checker/network_checker.dart';
import 'package:flutterpad/app/presentation/entities/task_entity.dart';
import 'package:flutterpad/app/presentation/repositories/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final NetworkChecker _networkChecker;
  final TasksRemoteDatasource _remoteDatasource;
  final TasksLocalDatasource _localDatasource;

  TasksRepositoryImpl(this._localDatasource, this._networkChecker, this._remoteDatasource);

  @override
  Future<List<TaskEntity>> getCompletedTasksInLastMonth() async {
    return _localDatasource.getCompletedTasksInLastMonth();
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

  @override
  Future<void> synchronizeTasks() async {
    if (await _networkChecker.isConnected) {
      final tasksToSync = await _localDatasource.getTasksNotSynchronized();
      for (final toSyncTask in tasksToSync) {
        TaskEntity task = IsarTaskAdapter.toEntity(toSyncTask);
        if (toSyncTask.createdRemotelly) {
          await _remoteDatasource.updateTask(task);
          await _localDatasource.saveTask(task, true);
        } else {
          final remoteId = await _remoteDatasource.createTask(task);
          await _localDatasource.saveTask(task, true, newTaskId: remoteId);
        }
      }
      final remoteRequest = await Future.wait(
          [_remoteDatasource.getPendingTasks(), _remoteDatasource.getCompletedTasksInLastMonth()]);
      final remoteTasks = [...remoteRequest[0], ...remoteRequest[1]];
      for (final remoteTask in remoteTasks) {
        await _localDatasource.saveTask(remoteTask, true);
      }
    }
  }
}