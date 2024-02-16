import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/di/di.dart';
import 'package:flutterpad/app/core/utils/constants.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';
import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/presentation/components/home/task_item_widget.dart';
import 'package:flutterpad/app/presentation/stores/get_tasks_store.dart';
import 'package:flutterpad/app/presentation/stores/mark_task_completion_store.dart';

class CompletedTaskListWidget extends StatefulWidget {
  final List<TaskEntity> completedTasks;
  const CompletedTaskListWidget({
    Key? key,
    required this.completedTasks,
  }) : super(key: key);

  @override
  State<CompletedTaskListWidget> createState() => _CompletedTaskListWidgetState();
}

class _CompletedTaskListWidgetState extends State<CompletedTaskListWidget> {
  final markStore = locator.get<MarkTaskCompletionStore>();
  final getStore = locator.get<GetTasksStore>();

  @override
  void initState() {
    super.initState();
    markStore.addListener(listener);
  }

  void listener() {
    if (markStore.state is MarkTaskCompletionSuccessState) {
      getStore.getTasks();
    } else if (markStore.state is MarkTaskCompletionErrorState) {
      log("ERROR");
    }
  }

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
            itemCount: widget.completedTasks.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = widget.completedTasks[index];
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
        ),
      ],
    );
  }
}
