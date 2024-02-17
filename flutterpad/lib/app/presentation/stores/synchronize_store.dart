import 'package:equatable/equatable.dart';
import 'package:flutterpad/app/core/utils/notifier.dart';
import 'package:flutterpad/app/domain/usecases/synchronize_tasks_usecase.dart';

class SynchronizeStore extends Notifier {
  final SynchronizeTasksUsecase _usecase;

  SynchronizeStore(this._usecase);

  SynchronizeState _state = SynchronizeInitialState();

  Future<void> synchronize() async {
    _state = SynchronizeLoadingState();
    notifyListeners();
    try {
      await _usecase.call({});
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
