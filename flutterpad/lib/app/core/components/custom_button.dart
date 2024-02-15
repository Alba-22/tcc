import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/utils/constants.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.text,
    this.isLoading = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Layout.buttonHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RadiusSize.extraBig),
        color: CustomColors.primary,
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: CustomColors.fullWhite,
              ),
            )
          : Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  color: CustomColors.fullWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
