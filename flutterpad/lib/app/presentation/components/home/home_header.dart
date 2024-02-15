import 'dart:math';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';
import 'package:intl/intl.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateStr = DateFormat("MMMM dd, yyyy", "pt-BR").format(clock.now());
    dateStr = dateStr[0].toUpperCase() + dateStr.substring(1);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: CustomColors.primary,
      child: Column(
        children: [
          SizedBox(height: max(MediaQuery.of(context).padding.top, 36)),
          Text(
            dateStr,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: CustomColors.fullWhite,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "FlutterPad\nTodo List",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColors.fullWhite,
              fontSize: 32,
              height: 1,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
