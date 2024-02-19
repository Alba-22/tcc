import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/utils/constants.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';
import 'package:flutterpad/app/core/utils/form_manager.dart';

class CustomTextField extends StatelessWidget {
  final FormObject form;

  const CustomTextField({
    Key? key,
    required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          form.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: CustomColors.text,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RadiusSize.interSmall),
              borderSide: const BorderSide(
                width: 1,
                color: CustomColors.border,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RadiusSize.interSmall),
              borderSide: const BorderSide(
                width: 1,
                color: CustomColors.border,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RadiusSize.interSmall),
              borderSide: const BorderSide(
                width: 1.5,
                color: CustomColors.primary,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RadiusSize.interSmall),
              borderSide: const BorderSide(
                width: 1,
                color: CustomColors.error,
              ),
            ),
            errorStyle: const TextStyle(
              color: CustomColors.error,
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
            filled: true,
            fillColor: CustomColors.fullWhite,
            hintText: form.placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              color: CustomColors.text.withOpacity(0.7),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          maxLines: form.totalLines,
          minLines: form.totalLines,
          controller: form.controller,
          onChanged: form.onChange,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: form.validator,
        ),
      ],
    );
  }
}
