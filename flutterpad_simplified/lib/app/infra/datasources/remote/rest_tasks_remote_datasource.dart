import 'package:clock/clock.dart';
import 'package:dio/dio.dart';
import 'package:flutterpad/app/infra/datasources/remote/tasks_remote_datasource.dart';
import 'package:flutterpad/app/infra/mappers/rest_task_mapper.dart';
import 'package:flutterpad/app/presentation/entities/task_entity.dart';

class RestTasksRemoteDatasource implements TasksRemoteDatasource {
  final Dio _dio;

  RestTasksRemoteDatasource(this._dio);

  static get baseUrl => const String.fromEnvironment("BASE_URL");

  @override
  Future<String> createTask(TaskEntity task) async {
    final response = await _dio.post(
      "$baseUrl/tasks",
      data: RestTaskMapper.toMap(task),
    );
    return response.data["id"];
  }

  @override
  Future<List<TaskEntity>> getCompletedTasksInLastMonth() async {
    final response = await _dio.get("$baseUrl/tasks");
    final List<TaskEntity> tasks = response.data.map<TaskEntity>((e) {
      return RestTaskMapper.fromMap(e);
    }).toList();
    return tasks
        .where((element) =>
            element.completed == true &&
            element.date.compareTo(clock.now().subtract(const Duration(days: 30))) == 1)
        .toList();
  }

  @override
  Future<List<TaskEntity>> getPendingTasks() async {
    final response = await _dio.get("$baseUrl/tasks");
    final List<TaskEntity> tasks = response.data.map<TaskEntity>((e) {
      return RestTaskMapper.fromMap(e);
    }).toList();
    return tasks.where((element) => element.completed == false).toList();
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await _dio.put("$baseUrl/tasks/${task.id}", data: RestTaskMapper.toMap(task));
  }
}
