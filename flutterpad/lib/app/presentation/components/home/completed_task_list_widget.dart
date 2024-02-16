import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/utils/constants.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';
import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/presentation/components/home/task_item_widget.dart';

class CompletedTaskListWidget extends StatelessWidget {
  final List<TaskEntity> completedTasks;
  const CompletedTaskListWidget({
    Key? key,
    required this.completedTasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Finalizadas",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: CustomColors.text,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            color: CustomColors.fullWhite,
            borderRadius: BorderRadius.circular(RadiusSize.medium),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: completedTasks.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = completedTasks[index];
              return TaskItemWidget(
                text: item.text,
                date: item.date,
                isCompleted: item.completed,
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: 1,
                color: CustomColors.border,
              );
            },
          ),
        ),
      ],
    );
  }
}
