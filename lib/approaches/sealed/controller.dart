import 'package:poc_tcc/common/notifier.dart';
import 'package:poc_tcc/model/error_exception.dart';
import 'package:poc_tcc/model/success_model.dart';
import 'package:poc_tcc/repository/get_information_from_network.dart';

class Controller extends Notifier {
  InfoState _state = InfoInitialState();

  Future<void> getInformation() async {
    try {
      _state = InfoLoadingState();
      notifyListeners();

      final result = await getInformationFromNetwork();

      _state = InfoSuccessState(result);
      notifyListeners();
    } on ErrorException catch (exception) {
      _state = InfoErrorState(exception.message);
      notifyListeners();
    }
  }

  InfoState get state => _state;
}

sealed class InfoState {}

final class InfoInitialState extends InfoState {}

final class InfoLoadingState extends InfoState {}

final class InfoSuccessState extends InfoState {
  final SuccessModel successData;
  InfoSuccessState(this.successData);
}

final class InfoErrorState extends InfoState {
  final String message;
  InfoErrorState(this.message);
}
