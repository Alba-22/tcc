import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/components/custom_button.dart';
import 'package:flutterpad/app/core/di/di.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';
import 'package:flutterpad/app/core/utils/notifier_builder.dart';
import 'package:flutterpad/app/presentation/components/home/home_header.dart';
import 'package:flutterpad/app/presentation/components/home/home_success_widget.dart';
import 'package:flutterpad/app/presentation/stores/get_tasks_store.dart';
import 'package:flutterpad/app/presentation/stores/mark_task_completion_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final getStore = locator.get<GetTasksStore>();
  final markStore = locator.get<MarkTaskCompletionStore>();

  void listener() {
    if (markStore.state is MarkTaskCompletionSuccessState) {
      getStore.getTasks();
    } else if (markStore.state is MarkTaskCompletionErrorState) {
      log("ERROR");
    }
  }

  @override
  void initState() {
    super.initState();
    getStore.getTasks();
    markStore.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: NotifierBuilder(
              controller: getStore,
              builder: () {
                return switch (getStore.state) {
                  GetTasksInitialState() => const SizedBox(),
                  GetTasksLoadingState() => const Center(child: CircularProgressIndicator()),
                  GetTasksErrorState(message: final message) => Text(message),
                  GetTasksSuccessState(
                    pendingTasks: final pending,
                    completedTasks: final completed
                  ) =>
                    HomeSuccessWidget(pendingTasks: pending, completedTasks: completed),
                };
              },
            ),
          ),
          Container(
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
            child: CustomButton(
              text: "Nova tarefa",
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    markStore.removeListener(listener);
    super.dispose();
  }
}
