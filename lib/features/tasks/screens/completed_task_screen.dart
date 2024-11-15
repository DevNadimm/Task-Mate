import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/controllers/completed_task_list_controller.dart';
import 'package:task_mate/core/utils/progress_indicator.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/features/tasks/widgets/no_task_widget.dart';
import 'package:task_mate/features/tasks/widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    _getCompletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
    final controller = CompletedTaskListController.instance;
    final result = await controller.getCancelledTaskList();
    if (!result) {
      ToastMessage.errorToast(controller.errorMessage!);
    }
  }
}
