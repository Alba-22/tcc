import 'package:equatable/equatable.dart';
import 'package:flutterpad/app/core/utils/notifier.dart';
import 'package:flutterpad/app/presentation/repositories/tasks_repository.dart';

class SynchronizeStore extends Notifier {
  final TasksRepository _repository;

  SynchronizeStore(this._repository);

  SynchronizeState _state = SynchronizeInitialState();

  Future<void> synchronize() async {
    _state = SynchronizeLoadingState();
    notifyListeners();
    try {
      await _repository.synchronizeTasks();
      _state = SynchronizeSuccessState();
    } catch (exception) {
      _state = SynchronizeErrorState("Ocorreu um erro ao sincronizar os dados");
    } finally {
      notifyListeners();
    }
  }

  SynchronizeState get state => _state;
}

sealed class SynchronizeState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SynchronizeInitialState extends SynchronizeState {}

final class SynchronizeLoadingState extends SynchronizeState {}

final class SynchronizeSuccessState extends SynchronizeState {}

final class SynchronizeErrorState extends SynchronizeState {
  final String message;
  SynchronizeErrorState(this.message);
}
