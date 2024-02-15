import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/components/custom_button.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';
import 'package:flutterpad/app/presentation/components/home/completed_task_list_widget.dart';
import 'package:flutterpad/app/presentation/components/home/home_header.dart';
import 'package:flutterpad/app/presentation/components/home/pending_task_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    PendingTaskListWidget(),
                    CompletedTaskListWidget(),
                    SizedBox(height: 16),
                  ],
                ),
              ),
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
      // floatingActionButton: Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 16),
      //   child: CustomButton(
      //     text: "Nova tarefa",
      //     onTap: () {},
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
