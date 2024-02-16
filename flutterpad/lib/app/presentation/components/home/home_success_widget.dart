import 'package:flutter/material.dart';
import 'package:flutterpad/app/domain/entities/task_entity.dart';

import 'completed_task_list_widget.dart';
import 'pending_task_list_widget.dart';

class HomeSuccessWidget extends StatelessWidget {
  final List<TaskEntity> pendingTasks;
  final List<TaskEntity> completedTasks;

  const HomeSuccessWidget({
    Key? key,
    required this.pendingTasks,
    required this.completedTasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pendingTasks.isEmpty && completedTasks.isEmpty) {
      return const Center(
        child: Text("Nenhuma tarefa no momento"),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            if (pendingTasks.isNotEmpty) PendingTaskListWidget(pendingTasks: pendingTasks),
            if (completedTasks.isNotEmpty) CompletedTaskListWidget(completedTasks: completedTasks),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
