import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/utils/constants.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final bool isDisabled;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.text,
    this.isLoading = false,
    this.isDisabled = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled || isLoading ? null : onTap,
      child: Container(
        height: Layout.buttonHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusSize.extraBig),
          color: isDisabled ? CustomColors.border : CustomColors.primary,
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: isDisabled ? CustomColors.text : CustomColors.fullWhite,
                ),
              )
            : Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDisabled ? CustomColors.text : CustomColors.fullWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}
