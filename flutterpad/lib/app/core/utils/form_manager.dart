import 'package:flutter/material.dart';

import 'notifier.dart';

typedef FormsMap = Map<String, FormObject>;

class FormManager extends Notifier {
  final FormsMap _forms = {};

  void setForms(Map<String, FormObjectParameters> input) {
    for (final i in input.entries) {
      _forms.addAll({
        i.key: FormObject(
          label: i.value.label,
          placeholder: i.value.placeholder,
          validator: i.value.validator,
          totalLines: i.value.totalLines,
          controller: TextEditingController(),
          onChange: (p0) {
            _checkIsValid();
            notifyListeners();
          },
        ),
      });
      if (i.value.initialValue != null) {
        _forms[i.key]!.controller.text = i.value.initialValue!;
      }
    }
    _checkIsValid();
  }

  void _checkIsValid() {
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
  final String placeholder;
  final int totalLines;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final void Function(String?) onChange;

  FormObject({
    required this.label,
    required this.placeholder,
    required this.validator,
    required this.controller,
    required this.onChange,
    required this.totalLines,
  });
}

class FormObjectParameters {
  final String label;
  final String placeholder;
  final int totalLines;
  final String? initialValue;
  final String? Function(String?) validator;

  FormObjectParameters({
    required this.label,
    required this.placeholder,
    required this.validator,
    this.initialValue,
    this.totalLines = 1,
  });
}
