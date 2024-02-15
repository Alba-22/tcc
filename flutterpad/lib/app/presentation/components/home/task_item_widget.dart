import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/components/custom_checkbox.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';
import 'package:intl/intl.dart';

class TaskItemWidget extends StatelessWidget {
  final String text;
  final DateTime date;
  final bool isCompleted;

  const TaskItemWidget({
    Key? key,
    required this.text,
    required this.date,
    required this.isCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Opacity(
              opacity: isCompleted ? 0.5 : 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                      fontSize: 16,
                      color: CustomColors.text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat("dd/MM/yyyy - HH:MM", "pt-BR").format(date),
                    style: TextStyle(
                      decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                      fontSize: 14,
                      color: CustomColors.text,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomCheckbox(
            value: isCompleted,
            onTap: (value) {},
          ),
        ],
      ),
    );
  }
}
