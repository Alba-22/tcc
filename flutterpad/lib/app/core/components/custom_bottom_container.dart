import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';

class CustomBottomContainer extends StatelessWidget {
  final Widget child;
  const CustomBottomContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: const BoxDecoration(
        color: CustomColors.fullWhite,
        border: Border(
          top: BorderSide(
            width: 1,
            color: CustomColors.border,
          ),
        ),
      ),
      child: child,
    );
  }
}
