import 'package:email_validator/email_validator.dart';

class Validator {
  final String? valueToTest;
  final List<String> _errors = [];
  bool _isRequired = false;

  Validator(this.valueToTest);

  bool _checkRequired() {
    return !_isRequired && (valueToTest?.isEmpty ?? false);
  }

  Validator isPasswordValid([String? message]) {
    if (_checkRequired()) return this;

    if (!RegExp(r"^(?!.*\s)(?=.*\d)(?=.*[a-zA-Z]).+$").hasMatch(valueToTest!)) {
      _errors.add("A senha deve ter números e letras!");
    }
    return this;
  }

  Validator isEmailValid([String? message]) {
    if (_checkRequired()) return this;

    if (!EmailValidator.validate(valueToTest!)) {
      _errors.add(message ?? "E-mail inválido");
    }
    return this;
  }

  Validator isEqualTo(String toCompare, [String? message]) {
    if (_checkRequired()) return this;

    if (valueToTest != toCompare) {
      _errors.add(message ?? "Valores devem ser iguais");
    }
    return this;
  }

  Validator isRequired([String? message]) {
    _isRequired = true;
    if (valueToTest?.isEmpty ?? false) {
      _errors.add(message ?? "O campo é obrigatório.");
    }
    return this;
  }

  Validator maxLength(int max, [String? message]) {
    if (_checkRequired()) return this;
    if (valueToTest!.length > max) {
      _errors.add(message ?? "O tamanho máximo é $max!");
    }
    return this;
  }

  Validator minLength(int min) {
    if (_checkRequired()) return this;
    if (valueToTest!.length <= min) {
      _errors.add("O tamanho mínimo é $min!");
    }
    return this;
  }

  String? build([String join = '\n']) => _errors.isEmpty ? null : _errors.join(join);
}
