import 'package:flutter/material.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/features/tasks/widgets/task_card.dart';
import 'package:task_mate/models/task_list_model.dart';
import 'package:task_mate/models/task_model.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool inProgressTaskList = false;
  List<TaskModel> completedTaskList = [];

  @override
  void initState() {
    _getCompletedTaskList();
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
                itemCount: completedTaskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    task: completedTaskList[index],
                    refreshTaskList: () => _getCompletedTaskList,
                  );
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

  Future _getCompletedTaskList() async {
    completedTaskList.clear();
    setState(() => inProgressTaskList = true);

    NetworkResponse networkResponse =
        await NetworkCaller.getRequest(Urls.getCompletedTask);

    if (networkResponse.isSuccess) {
      final taskListModel =
          TaskListModel.fromJson(networkResponse.responseData);
      completedTaskList = taskListModel.taskList ?? [];
    } else {
      ToastMessage.errorToast(networkResponse.errorMessage);
    }
    setState(() => inProgressTaskList = false);
  }
}
