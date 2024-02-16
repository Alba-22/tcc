import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutterpad/app/core/errors/failure.dart';
import 'package:flutterpad/app/core/utils/notifier.dart';
import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/domain/usecases/mark_tasks_completion_usecase.dart';

class MarkTaskCompletionStore extends Notifier {
  final MarkTasksCompletionUsecase _usecase;

  MarkTaskCompletionStore(this._usecase);

  MarkTaskCompletionState _state = MarkTaskCompletionInitialState();

  Future<void> markTaskCompletion(TaskEntity task, bool completion) async {
    _state = MarkTaskCompletionLoadingState();
    notifyListeners();
    try {
      await _usecase.call((task: task, completion: completion));
      _state = MarkTaskCompletionSuccessState();
    } on Failure catch (failure) {
      _state = MarkTaskCompletionErrorState(failure.message);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      _state = MarkTaskCompletionErrorState(
        "Ocorreu um erro ao marcar a tarefa como ${completion ? "feita" : "não feita"}!",
      );
    } finally {
      notifyListeners();
    }
  }

  MarkTaskCompletionState get state => _state;
}

sealed class MarkTaskCompletionState extends Equatable {
  @override
  List<Object> get props => [];
}

final class MarkTaskCompletionInitialState extends MarkTaskCompletionState {}

final class MarkTaskCompletionLoadingState extends MarkTaskCompletionState {}

final class MarkTaskCompletionSuccessState extends MarkTaskCompletionState {}

final class MarkTaskCompletionErrorState extends MarkTaskCompletionState {
  final String message;
  MarkTaskCompletionErrorState(this.message);
}
