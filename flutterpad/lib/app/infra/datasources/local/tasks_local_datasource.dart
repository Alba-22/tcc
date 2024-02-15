import 'package:flutterpad/app/domain/entities/task_entity.dart';

abstract interface class TasksLocalDatasource {
  Future<void> markTaskAsSynchronized(TaskEntity task);
  Future<void> saveTask(TaskEntity task, bool synchorized);
  Future<TaskEntity> getTaskById(String id);
  Future<List<TaskEntity>> getPendingTasks();
  Future<List<TaskEntity>> getCompletedTasksInLast24Hours();
}
