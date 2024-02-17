import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/infra/models/isar_task_model.dart';

abstract interface class TasksLocalDatasource {
  Future<void> saveTask(TaskEntity task, bool synchorized, {String? newTaskId});
  Future<IsarTaskModel?> getTaskById(String id);
  Future<List<TaskEntity>> getPendingTasks();
  Future<List<TaskEntity>> getCompletedTasksInLast24Hours();
  Future<List<IsarTaskModel>> getTasksNotSynchronized();
}
