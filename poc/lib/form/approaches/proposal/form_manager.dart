import 'package:flutter/material.dart';

import '../../utils/notifier.dart';

typedef FormsMap = Map<String, FormObject>;

class FormManager extends Notifier {
  final FormsMap _forms = {};

  void setForms(Map<String, FormObjectParameters> input) {
    for (final i in input.entries) {
      _forms.addAll({
        i.key: FormObject(
          label: i.value.label,
          validator: i.value.validator,
          controller: TextEditingController(),
          onChange: (p0) {
            checkIsValid();
            notifyListeners();
          },
        ),
      });
    }
  }

  void checkIsValid() {
    for (final item in _forms.entries) {
      if (item.value.validator(item.value.controller.text) != null) {
        _isValid = false;
        return;
      }
    }
    _isValid = true;
    return;
  }

  Map<String, FormObject> get forms => _forms;

  bool _isValid = false;

  bool get isValid => _isValid;
}

class FormObject {
  final String label;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final void Function(String?) onChange;

  FormObject({
    required this.label,
    required this.validator,
    required this.controller,
    required this.onChange,
  });
}

class FormObjectParameters {
  final String label;
  final String? Function(String?) validator;

  FormObjectParameters({
    required this.label,
    required this.validator,
  });
}
