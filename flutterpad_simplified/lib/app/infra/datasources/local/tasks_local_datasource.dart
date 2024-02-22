import 'package:flutterpad/app/infra/models/isar_task_model.dart';
import 'package:flutterpad/app/presentation/entities/task_entity.dart';

abstract interface class TasksLocalDatasource {
  Future<void> saveTask(TaskEntity task, bool synchorized, {String? newTaskId});
  Future<IsarTaskModel?> getTaskById(String id);
  Future<List<IsarTaskModel>> getPendingTasks();
  Future<List<IsarTaskModel>> getCompletedTasksInLastMonth();
  Future<List<IsarTaskModel>> getTasksNotSynchronized();
}
