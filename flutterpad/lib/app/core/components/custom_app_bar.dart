import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  const CustomAppBar({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72 + MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: CustomColors.primary,
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.fullWhite,
              ),
              child: const Icon(
                Icons.chevron_left,
                size: 24,
                color: CustomColors.text,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: CustomColors.fullWhite,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 48,
          ),
        ],
      ),
    );
  }
}
