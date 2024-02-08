import 'package:flutter/material.dart';

import 'form_manager.dart';

class CustomTextField extends StatelessWidget {
  final FormsMap forms;
  final String formRef;

  const CustomTextField({
    Key? key,
    required this.forms,
    required this.formRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(forms[formRef]!.label),
      ),
      obscureText: forms[formRef]!.hide,
      controller: forms[formRef]!.controller,
      onChanged: forms[formRef]!.onChange,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: forms[formRef]!.validator,
    );
  }
}
