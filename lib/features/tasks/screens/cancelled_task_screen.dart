import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/controllers/cancelled_task_list_controller.dart';
import 'package:task_mate/core/utils/progress_indicator.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/features/tasks/widgets/no_task_widget.dart';
import 'package:task_mate/features/tasks/widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  void initState() {
    _getCancelledTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GetBuilder<CancelledTaskListController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.inProgress,
            replacement: const ProgressIndicatorWidget(),
            child: controller.cancelledTaskList.isEmpty
                ? const NoTaskWidget()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.cancelledTaskList.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: controller.cancelledTaskList[index],
                              refreshTaskList: _getCancelledTaskList,
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

  Future<void> _getCancelledTaskList() async {
    final controller = CancelledTaskListController.instance;
    final result = await controller.getCancelledTaskList();

    if (!result) {
      ToastMessage.errorToast(controller.errorMessage!);
    }
  }
}
