import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutterpad/app/core/errors/failure.dart';
import 'package:flutterpad/app/core/utils/notifier.dart';
import 'package:flutterpad/app/presentation/entities/task_entity.dart';
import 'package:flutterpad/app/presentation/repositories/tasks_repository.dart';

class GetTasksStore extends Notifier {
  final TasksRepository _repository;

  GetTasksState _state = GetTasksInitialState();

  GetTasksStore(this._repository);

  Future<void> getTasks() async {
    if (_state is GetTasksInitialState) {
      _state = GetTasksLoadingState();
      notifyListeners();
    }
    try {
      final pendingTasks = await _repository.getPendingTasks();
      final completedTasks = await _repository.getCompletedTasksInLastMonth();
      _state = GetTasksSuccessState(pendingTasks, completedTasks);
    } on Failure catch (failure) {
      _state = GetTasksErrorState(failure.message);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      _state = GetTasksErrorState("Ocorreu um erro. Tente novamente mais tarde");
    } finally {
      notifyListeners();
    }
  }

  GetTasksState get state => _state;
}

sealed class GetTasksState extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetTasksInitialState extends GetTasksState {}

final class GetTasksLoadingState extends GetTasksState {}

final class GetTasksSuccessState extends GetTasksState {
  final List<TaskEntity> pendingTasks;
  final List<TaskEntity> completedTasks;
  GetTasksSuccessState(this.pendingTasks, this.completedTasks);
}

final class GetTasksErrorState extends GetTasksState {
  final String message;
  GetTasksErrorState(this.message);
}
