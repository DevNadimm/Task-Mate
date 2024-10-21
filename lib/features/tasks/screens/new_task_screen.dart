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

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool inProgressTaskList = false;
  List<TaskModel> newTaskList = [];

  @override
  void initState() {
    _getNewTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TaskSummeryCard(title: 'New', count: 09),
                  TaskSummeryCard(title: 'Completed', count: 09),
                  TaskSummeryCard(title: 'Cancelled', count: 09),
                  TaskSummeryCard(title: 'Progress ', count: 09),
                ],
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: !inProgressTaskList,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      task: newTaskList[index],
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

  Future<void> _onTapBottomNavBar(BuildContext context) async {
    final shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
    if (shouldRefresh == true) {
      _getNewTaskList();
    }
  }

  Future _getNewTaskList() async {
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
}
