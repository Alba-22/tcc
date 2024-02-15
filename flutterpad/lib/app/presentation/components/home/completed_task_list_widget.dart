import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/utils/constants.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';
import 'package:flutterpad/app/presentation/components/home/task_item_widget.dart';

class CompletedTaskListWidget extends StatelessWidget {
  const CompletedTaskListWidget({Key? key}) : super(key: key);

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
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return TaskItemWidget(
                text: "Tarefa ${index + 1}",
                date: DateTime.now(),
                isCompleted: true,
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
