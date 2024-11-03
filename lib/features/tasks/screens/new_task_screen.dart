import 'package:flutter/material.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/colors.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/features/tasks/widgets/task_card.dart';
import 'package:task_mate/features/tasks/widgets/task_summery_card.dart';
import 'package:task_mate/features/tasks/screens/add_new_task_screen.dart';
import 'package:task_mate/models/task_list_model.dart';
import 'package:task_mate/models/task_model.dart';
import 'package:task_mate/models/task_status_count_model.dart';
import 'package:task_mate/models/task_status_model.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool inProgressTaskList = false;
  bool inProgressStatusCount = false;
  bool inProgress = true;
  List<TaskModel> newTaskList = [];
  List<TaskStatusModel> taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final taskStatusCount = _getTaskStatusCount();
    final newTaskList = _getNewTaskList();

    await Future.wait([taskStatusCount, newTaskList]);
    setState(() {
      inProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Visibility(
        visible: !inProgress,
        replacement: const Center(child: CircularProgressIndicator()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                buildSummery(),
                const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      task: newTaskList[index],
                      refreshTaskList: () => setState(() {
                        inProgress = true;
                        _fetchData();
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => _onTapBottomNavBar(context),
        child: const Icon(
          Icons.add_circle_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildSummery() {
    return Row(
      children: taskStatusCountList.map((task) {
        return TaskSummeryCard(
          id: task.id!,
          sum: task.sum!,
        );
      }).toList(),
    );
  }

  Future<void> _onTapBottomNavBar(BuildContext context) async {
    final shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
    if (shouldRefresh == true) {
      await Future.wait([_getNewTaskList(), _getTaskStatusCount()]);
    }
  }

  Future<void> _getNewTaskList() async {
    newTaskList.clear();
    setState(() => inProgressTaskList = true);

    NetworkResponse networkResponse =
        await NetworkCaller.getRequest(Urls.getNewTask);

    if (networkResponse.isSuccess) {
      final taskListModel =
          TaskListModel.fromJson(networkResponse.responseData);
      newTaskList = taskListModel.taskList ?? [];
    } else {
      ToastMessage.errorToast(networkResponse.errorMessage);
    }
    setState(() => inProgressTaskList = false);
  }

  Future<void> _getTaskStatusCount() async {
    taskStatusCountList.clear();
    setState(() => inProgressStatusCount = true);

    NetworkResponse networkResponse =
        await NetworkCaller.getRequest(Urls.getTaskStatusCount);

    if (networkResponse.isSuccess) {
      final taskStatusCount =
          TaskStatusCountModel.fromJson(networkResponse.responseData);
      taskStatusCountList = taskStatusCount.taskStatusCountList ?? [];
    } else {
      ToastMessage.errorToast(networkResponse.errorMessage);
    }
    setState(() => inProgressStatusCount = false);
  }
}
