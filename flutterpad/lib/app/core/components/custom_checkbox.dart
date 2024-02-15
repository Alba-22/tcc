import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/utils/constants.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final void Function(bool value) onTap;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RadiusSize.small),
        border: Border.all(
          width: 1,
          color: CustomColors.text,
        ),
        color: value ? CustomColors.text : CustomColors.fullWhite,
      ),
      child: value
          ? const Center(
              child: Icon(
                Icons.check,
                size: 20,
                color: CustomColors.fullWhite,
              ),
            )
          : const SizedBox(),
    );
  }
}
