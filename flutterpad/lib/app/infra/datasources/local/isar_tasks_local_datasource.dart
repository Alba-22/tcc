import 'package:clock/clock.dart';
import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/infra/datasources/local/tasks_local_datasource.dart';
import 'package:flutterpad/app/infra/mappers/isar_task_mapper.dart';
import 'package:flutterpad/app/infra/models/isar_task_model.dart';
import 'package:isar/isar.dart';

class IsarTasksLocalDatasource implements TasksLocalDatasource {
  final Isar _isar;

  IsarTasksLocalDatasource(this._isar);

  @override
  Future<List<TaskEntity>> getCompletedTasksInLastMonth() async {
    final collection = _isar.collection<IsarTaskModel>();
    final tasks = await collection
        .filter()
        .completionEqualTo(true)
        .dateGreaterThan(clock.now().subtract(const Duration(days: 30)))
        .findAll();
    return tasks.map((taskModel) {
      return IsarTaskMapper.toEntity(taskModel);
    }).toList();
  }

  @override
  Future<List<TaskEntity>> getPendingTasks() async {
    final collection = _isar.collection<IsarTaskModel>();
    final tasks = await collection.filter().completionEqualTo(false).findAll();
    return tasks.map((taskModel) {
      return IsarTaskMapper.toEntity(taskModel);
    }).toList();
  }

  @override
  Future<IsarTaskModel?> getTaskById(String id) async {
    final collection = _isar.collection<IsarTaskModel>();
    return await collection.filter().taskIdEqualTo(id).findFirst();
  }

  @override
  Future<void> saveTask(TaskEntity task, bool synchorized, {String? newTaskId}) async {
    final collection = _isar.collection<IsarTaskModel>();
    final taskModel = IsarTaskMapper.fromEntity(task);
    final existingTaskOnDb = await collection.filter().taskIdEqualTo(task.id).findFirst();
    if (existingTaskOnDb != null) {
      taskModel.id = existingTaskOnDb.id;
      taskModel.createdRemotelly = existingTaskOnDb.createdRemotelly;
    }
    if (synchorized == false) {
      taskModel.syncDate = null;
    } else {
      taskModel.syncDate = clock.now();
      taskModel.createdRemotelly = true;
    }
    if (newTaskId != null) {
      taskModel.taskId = newTaskId;
    }
    await _isar.writeTxn(() async {
      await collection.put(taskModel);
    });
  }

  @override
  Future<List<IsarTaskModel>> getTasksNotSynchronized() async {
    final collection = _isar.collection<IsarTaskModel>();
    return await collection.filter().syncDateIsNull().findAll();
  }
}
