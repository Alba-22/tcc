import '../../common/notifier.dart';
import '../../model/error_exception.dart';
import '../../model/success_model.dart';
import '../../repository/get_information_from_network.dart';

class Controller extends Notifier {
  bool _isLoading = false;
  String? _errorMessage;
  SuccessModel? _successData;

  Future<void> getInformation() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      _successData = null;
      notifyListeners();

      final result = await getInformationFromNetwork();

      _successData = result;
      _isLoading = false;
      notifyListeners();
    } on ErrorException catch (exception) {
      _errorMessage = exception.message;
      _isLoading = false;
      notifyListeners();
    }
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  SuccessModel? get successData => _successData;
}
