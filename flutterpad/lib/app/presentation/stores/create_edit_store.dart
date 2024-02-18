import 'package:equatable/equatable.dart';
import 'package:flutterpad/app/core/utils/notifier.dart';
import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/domain/usecases/create_task_usecase.dart';
import 'package:flutterpad/app/domain/usecases/edit_task_usecase.dart';

class CreateEditStore extends Notifier {
  final CreateTaskUsecase _createTaskUsecase;
  final EditTaskUsecase _editTaskUsecase;

  CreateEditStore(this._createTaskUsecase, this._editTaskUsecase);

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
        await _editTaskUsecase.call((
          id: task.id,
          text: text,
          date: dateObj,
          description: description,
          completed: task.completed,
        ));
      } else {
        await _createTaskUsecase.call((text: text, date: dateObj, description: description));
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
