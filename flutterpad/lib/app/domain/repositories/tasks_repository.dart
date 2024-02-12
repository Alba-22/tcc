import 'package:flutterpad/app/domain/entities/task_entity.dart';

abstract interface class TasksRepository {
  Future<TaskEntity?> getTaskById(String id);
  Future<void> saveTask(TaskEntity task);
  Future<List<TaskEntity>> getPendingTasks();
  Future<List<TaskEntity>> getCompletedTasksInLast24Hours();
}
