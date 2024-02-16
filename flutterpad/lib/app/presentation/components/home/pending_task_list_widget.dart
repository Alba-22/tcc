import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/di/di.dart';
import 'package:flutterpad/app/core/utils/constants.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';
import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/presentation/components/home/task_item_widget.dart';
import 'package:flutterpad/app/presentation/stores/mark_task_completion_store.dart';

class PendingTaskListWidget extends StatefulWidget {
  final List<TaskEntity> pendingTasks;

  const PendingTaskListWidget({
    Key? key,
    required this.pendingTasks,
  }) : super(key: key);

  @override
  State<PendingTaskListWidget> createState() => _PendingTaskListWidgetState();
}

class _PendingTaskListWidgetState extends State<PendingTaskListWidget> {
  final markStore = locator.get<MarkTaskCompletionStore>();

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
        itemCount: widget.pendingTasks.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = widget.pendingTasks[index];
          return TaskItemWidget(
            text: item.text,
            date: item.date,
            isCompleted: item.completed,
            onTapCheckbox: (value) {
              markStore.markTaskCompletion(item, value);
            },
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
