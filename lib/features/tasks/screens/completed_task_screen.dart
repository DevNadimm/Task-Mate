import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/controllers/completed_task_list_controller.dart';
import 'package:task_mate/core/utils/progress_indicator.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/features/tasks/widgets/no_task_widget.dart';
import 'package:task_mate/features/tasks/widgets/task_card.dart';

class CompletedTaskScreen extends StatelessWidget {
  final completedTaskListController = CompletedTaskListController.instance;

  CompletedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _getCompletedTaskList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GetBuilder<CompletedTaskListController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.inProgress,
            replacement: const ProgressIndicatorWidget(),
            child: controller.completedTaskList.isEmpty
                ? const NoTaskWidget()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.completedTaskList.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: controller.completedTaskList[index],
                              refreshTaskList: _getCompletedTaskList,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8);
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Future<void> _getCompletedTaskList() async {
    final result = await completedTaskListController.getCancelledTaskList();
    if (!result) {
      ToastMessage.errorToast(completedTaskListController.errorMessage!);
    }
  }
}
