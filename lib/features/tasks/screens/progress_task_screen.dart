import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/controllers/progress_task_list_controller.dart';
import 'package:task_mate/core/utils/progress_indicator.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/features/tasks/widgets/no_task_widget.dart';
import 'package:task_mate/features/tasks/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    _getProgressTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GetBuilder<ProgressTaskListController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.inProgress,
            replacement: const ProgressIndicatorWidget(),
            child: controller.progressTaskList.isEmpty
                ? const NoTaskWidget()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.progressTaskList.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: controller.progressTaskList[index],
                              refreshTaskList: _getProgressTaskList,
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

  Future<void> _getProgressTaskList() async {
    final controller = ProgressTaskListController.instance;
    final result = await controller.getProgressTaskList();

    if (!result) {
      ToastMessage.errorToast(controller.errorMessage!);
    }
  }
}
