import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/components/custom_bottom_container.dart';
import 'package:flutterpad/app/core/components/custom_button.dart';
import 'package:flutterpad/app/core/di/di.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';
import 'package:flutterpad/app/core/utils/notifier_builder.dart';
import 'package:flutterpad/app/infra/services/network_checker/network_checker.dart';
import 'package:flutterpad/app/presentation/components/home/home_header.dart';
import 'package:flutterpad/app/presentation/components/home/home_success_widget.dart';
import 'package:flutterpad/app/presentation/stores/get_tasks_store.dart';
import 'package:flutterpad/app/presentation/stores/mark_task_completion_store.dart';
import 'package:flutterpad/app/presentation/stores/synchronize_store.dart';

import 'create_edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final getStore = locator.get<GetTasksStore>();
  final markStore = locator.get<MarkTaskCompletionStore>();
  final syncStore = locator.get<SynchronizeStore>();
  final networkChecker = locator.get<NetworkChecker>();

  void markCompletionListener() {
    if (markStore.state is MarkTaskCompletionSuccessState) {
      getStore.getTasks();
      syncStore.synchronize();
    } else if (markStore.state is MarkTaskCompletionErrorState) {
      log("ERROR");
    }
  }

  void synchronizeListener() {
    if (syncStore.state is SynchronizeSuccessState) {
      getStore.getTasks();
    }
  }

  @override
  void initState() {
    super.initState();
    onStart();
    markStore.addListener(markCompletionListener);
    syncStore.addListener(synchronizeListener);
    networkChecker.onConnectionChange.listen((event) {
      if (event == NetworkStatus.connected) {
        syncStore.synchronize();
      }
    });
  }

  void onStart() {
    getStore.getTasks();
    syncStore.synchronize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: RefreshIndicator(
        onRefresh: () async => onStart(),
        child: Column(
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
                      HomeSuccessWidget(
                        pendingTasks: pending,
                        completedTasks: completed,
                      ),
                  };
                },
              ),
            ),
            CustomBottomContainer(
              child: CustomButton(
                text: "Nova tarefa",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateEditPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    markStore.removeListener(markCompletionListener);
    syncStore.removeListener(synchronizeListener);
    super.dispose();
  }
}
