import 'package:flutter/material.dart';

import 'form_manager.dart';

class CustomTextField extends StatelessWidget {
  final FormObject form;

  const CustomTextField({
    Key? key,
    required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(form.label),
      ),
      controller: form.controller,
      onChanged: form.onChange,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: form.validator,
    );
  }
}
