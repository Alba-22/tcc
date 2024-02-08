import '../../common/notifier.dart';
import '../../model/error_exception.dart';
import '../../model/success_model.dart';
import '../../repository/get_information_from_network.dart';

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

abstract class InfoState {}

class InfoInitialState extends InfoState {}

class InfoLoadingState extends InfoState {}

class InfoSuccessState extends InfoState {
  final SuccessModel successData;
  InfoSuccessState(this.successData);
}

class InfoErrorState extends InfoState {
  final String message;
  InfoErrorState(this.message);
}
