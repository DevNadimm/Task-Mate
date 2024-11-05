import 'package:flutter/material.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/features/tasks/widgets/no_task_widget.dart';
import 'package:task_mate/features/tasks/widgets/task_card.dart';
import 'package:task_mate/models/task_list_model.dart';
import 'package:task_mate/models/task_model.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool inProgressTaskList = false;
  List<TaskModel> progressTaskList = [];

  @override
  void initState() {
    _getProgressTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Visibility(
        visible: !inProgressTaskList,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: progressTaskList.isEmpty
            ? const NoTaskWidget()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: progressTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          task: progressTaskList[index],
                          refreshTaskList: () => setState(() {
                            _getProgressTaskList();
                          }),
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
      ),
    );
  }

  Future<void> _getProgressTaskList() async {
    progressTaskList.clear();
    setState(() => inProgressTaskList = true);

    NetworkResponse networkResponse =
        await NetworkCaller.getRequest(Urls.getProgressTask);

    if (networkResponse.isSuccess) {
      final taskListModel =
          TaskListModel.fromJson(networkResponse.responseData);
      progressTaskList = taskListModel.taskList ?? [];
    } else {
      ToastMessage.errorToast(networkResponse.errorMessage);
    }
    setState(() => inProgressTaskList = false);
  }
}
