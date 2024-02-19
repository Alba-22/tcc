import 'package:flutterpad/app/infra/models/isar_task_model.dart';
import 'package:flutterpad/app/presentation/entities/task_entity.dart';

abstract interface class TasksLocalDatasource {
  Future<void> saveTask(TaskEntity task, bool synchorized, {String? newTaskId});
  Future<IsarTaskModel?> getTaskById(String id);
  Future<List<TaskEntity>> getPendingTasks();
  Future<List<TaskEntity>> getCompletedTasksInLast24Hours();
  Future<List<IsarTaskModel>> getTasksNotSynchronized();
}
