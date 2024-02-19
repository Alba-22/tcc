import 'package:equatable/equatable.dart';
import 'package:flutterpad/app/core/utils/notifier.dart';
import 'package:flutterpad/app/presentation/entities/task_entity.dart';
import 'package:flutterpad/app/presentation/repositories/tasks_repository.dart';
import 'package:uuid/uuid.dart';

class CreateEditStore extends Notifier {
  final TasksRepository _repository;
  final Uuid _uuid;

  CreateEditStore(this._repository, this._uuid);

  CreateEditTaskState _state = CreateEditTaskInitialState();

  Future<void> createEditTask(
    String text,
    String date,
    String time,
    String description,
    TaskEntity? task,
  ) async {
    _state = CreateEditTaskLoadingState();
    notifyListeners();
    try {
      final splittedDate = date.split("/");
      final splittedTime = time.split(":");
      final dateObj = DateTime(
        int.parse(splittedDate[2]),
        int.parse(splittedDate[1]),
        int.parse(splittedDate[0]),
        int.parse(splittedTime[0]),
        int.parse(splittedTime[1]),
      );
      if (task != null) {
        await _repository.updateTask(TaskEntity(
          id: task.id,
          text: text,
          date: dateObj,
          description: description,
          completed: task.completed,
        ));
      } else {
        await _repository.createTask(TaskEntity(
          id: _uuid.v4(),
          text: text,
          date: dateObj,
          description: description,
          completed: false,
        ));
      }
      _state = CreateEditTaskSuccessState();
    } catch (_) {
      _state = CreateEditTaskErrorState("Ocorreu um erro ao adicionar a tarefa");
    } finally {
      notifyListeners();
    }
  }

  CreateEditTaskState get state => _state;
}

sealed class CreateEditTaskState extends Equatable {
  @override
  List<Object> get props => [];
}

final class CreateEditTaskInitialState extends CreateEditTaskState {}

final class CreateEditTaskLoadingState extends CreateEditTaskState {}

final class CreateEditTaskSuccessState extends CreateEditTaskState {}

final class CreateEditTaskErrorState extends CreateEditTaskState {
  final String message;
  CreateEditTaskErrorState(this.message);
}
