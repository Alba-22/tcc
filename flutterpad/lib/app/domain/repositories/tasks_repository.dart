import 'package:flutterpad/app/domain/entities/task_entity.dart';

abstract interface class TasksRepository {
  Future<void> createTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<List<TaskEntity>> getPendingTasks();
  Future<List<TaskEntity>> getCompletedTasksInLastMonth();
  Future<void> synchronizeTasks();
}
