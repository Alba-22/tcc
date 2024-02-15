import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/utils/constants.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';
import 'package:flutterpad/app/presentation/components/home/task_item_widget.dart';

class PendingTaskListWidget extends StatelessWidget {
  const PendingTaskListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.fullWhite,
        borderRadius: BorderRadius.circular(RadiusSize.medium),
      ),
      margin: const EdgeInsets.only(bottom: 24),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return TaskItemWidget(
            text: "Tarefa ${index + 1}",
            date: DateTime.now(),
            isCompleted: false,
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
    );
  }
}
