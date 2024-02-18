class Validator {
  final String? valueToTest;
  final List<String> _errors = [];
  bool _isRequired = false;
  static const _dateRegex =
      r"^(?:(?:31\/(?:0?[13578]|1[02])|30\/(?:0?[13-9]|1[0-2])|(?:0?[1-9]|1\d|2[0-8])\/(?:0?[1-9]|1[0-2]))\/(?:19|20)\d{2}|29\/0?2\/(?:(?:19|20)(?:04|08|[2468][048]|[13579][26])|(?:19|20)(?:00|16|[2468][048]|[3579][26])))$";
  static const _hourRegex = r"^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$";

  Validator(this.valueToTest);

  bool _checkRequired() {
    return !_isRequired && (valueToTest?.isEmpty ?? false);
  }

  Validator isEqualTo(String toCompare, [String? message]) {
    if (_checkRequired()) return this;

    if (valueToTest != toCompare) {
      _errors.add(message ?? "Valores devem ser iguais");
    }
    return this;
  }

  Validator isDateValid([String? message]) {
    if (_checkRequired()) return this;

    if (!RegExp(_dateRegex).hasMatch(valueToTest!)) {
      _errors.add(message ?? "Data inválida");
    }
    return this;
  }

  Validator isHourValid([String? message]) {
    if (_checkRequired()) return this;

    if (!RegExp(_hourRegex).hasMatch(valueToTest!)) {
      _errors.add(message ?? "Hora inválida");
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
