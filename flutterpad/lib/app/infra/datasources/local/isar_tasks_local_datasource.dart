import 'package:clock/clock.dart';
import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/domain/errors/task_not_found_failure.dart';
import 'package:flutterpad/app/infra/adapters/isar_task_adapter.dart';
import 'package:flutterpad/app/infra/datasources/local/tasks_local_datasource.dart';
import 'package:flutterpad/app/infra/models/isar_task_model.dart';
import 'package:isar/isar.dart';

class IsarTasksLocalDatasource implements TasksLocalDatasource {
  final Isar _isar;

  IsarTasksLocalDatasource(this._isar);

  @override
  Future<List<TaskEntity>> getCompletedTasksInLast24Hours() async {
    final collection = _isar.collection<IsarTaskModel>();
    final tasks = await collection
        .filter()
        .completionEqualTo(true)
        .syncDateGreaterThan(clock.now().subtract(const Duration(hours: 24)))
        .findAll();
    return tasks.map((taskModel) {
      return IsarTaskAdapter.toEntity(taskModel);
    }).toList();
  }

  @override
  Future<List<TaskEntity>> getPendingTasks() async {
    final collection = _isar.collection<IsarTaskModel>();
    final tasks = await collection.filter().completionEqualTo(false).findAll();
    return tasks.map((taskModel) {
      return IsarTaskAdapter.toEntity(taskModel);
    }).toList();
  }

  @override
  Future<TaskEntity> getTaskById(String id) async {
    final collection = _isar.collection<IsarTaskModel>();
    final task = await collection.filter().taskIdEqualTo(id).findFirst();
    if (task == null) {
      throw TaskNotFoundFailure();
    }
    return IsarTaskAdapter.toEntity(task);
  }

  @override
  Future<void> saveTask(TaskEntity task, bool synchorized) async {
    final collection = _isar.collection<IsarTaskModel>();
    final taskModel = IsarTaskAdapter.fromEntity(task);
    final existingTaskOnDb = await collection.filter().taskIdEqualTo(task.id).findFirst();
    if (existingTaskOnDb != null) {
      taskModel.id = existingTaskOnDb.id;
    }
    if (synchorized == false) {
      taskModel.syncDate = null;
    } else {
      taskModel.syncDate = clock.now();
    }
    _isar.writeTxn(() async {
      await collection.put(taskModel);
    });
  }
}
