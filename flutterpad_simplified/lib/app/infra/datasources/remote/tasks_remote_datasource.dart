import 'package:flutterpad/app/presentation/entities/task_entity.dart';

abstract interface class TasksRemoteDatasource {
  Future<String> createTask(TaskEntity task);
  Future<List<TaskEntity>> getPendingTasks();
  Future<List<TaskEntity>> getCompletedTasksInLastMonth();
  Future<void> updateTask(TaskEntity task);
}
