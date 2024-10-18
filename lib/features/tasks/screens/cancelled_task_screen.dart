import 'package:flutter/material.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/features/tasks/widgets/task_card.dart';
import 'package:task_mate/models/task_list_model.dart';
import 'package:task_mate/models/task_model.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool inProgressTaskList = false;
  List<TaskModel> cancelledTaskList = [];

  @override
  void initState() {
    _getCancelledTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Visibility(
              visible: !inProgressTaskList,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cancelledTaskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(task: cancelledTaskList[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future _getCancelledTaskList() async {
    cancelledTaskList.clear();
    setState(() => inProgressTaskList = true);

    NetworkResponse networkResponse =
        await NetworkCaller.getRequest(Urls.getCancelledTask);

    if (networkResponse.isSuccess) {
      final taskListModel =
          TaskListModel.fromJson(networkResponse.responseData);
      cancelledTaskList = taskListModel.taskList ?? [];
    } else {
      ToastMessage.errorToast(networkResponse.errorMessage);
    }
    setState(() => inProgressTaskList = false);
  }
}
