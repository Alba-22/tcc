import 'package:flutterpad/app/domain/entities/task_entity.dart';

abstract interface class TasksRemoteDatasource {
  Future<String> createTask(TaskEntity task);
  Future<List<TaskEntity>> getPendingTasks();
  Future<List<TaskEntity>> getCompletedTasksInLast24Hours();
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask();
}
