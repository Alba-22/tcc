import 'package:clock/clock.dart';
import 'package:dio/dio.dart';
import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/infra/adapters/rest_task_adapter.dart';
import 'package:flutterpad/app/infra/datasources/remote/tasks_remote_datasource.dart';

class RestTasksRemoteDatasource implements TasksRemoteDatasource {
  final Dio _dio;

  RestTasksRemoteDatasource(this._dio);

  static get baseUrl => "localhost:8080";

  @override
  Future<String> createTask(TaskEntity task) async {
    final response = await _dio.post(
      "$baseUrl/tasks",
      data: RestTaskAdapter.toMap(task),
    );
    return response.data["id"];
  }

  @override
  Future<void> deleteTask() {
    throw UnimplementedError();
  }

  @override
  Future<List<TaskEntity>> getCompletedTasksInLast24Hours() async {
    final response = await _dio.get("$baseUrl/tasks");
    final List<TaskEntity> tasks = response.data.map<TaskEntity>((e) {
      return RestTaskAdapter.fromMap(e);
    }).toList();
    return tasks
        .where((element) => element.completed == true && element.date.compareTo(clock.now()) == 1)
        .toList();
  }

  @override
  Future<List<TaskEntity>> getPendingTasks() async {
    final response = await _dio.get("$baseUrl/tasks");
    final List<TaskEntity> tasks = response.data.map<TaskEntity>((e) {
      return RestTaskAdapter.fromMap(e);
    }).toList();
    return tasks.where((element) => element.completed == false).toList();
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await _dio.put("$baseUrl/tasks/${task.id}", data: RestTaskAdapter.toMap(task));
  }
}