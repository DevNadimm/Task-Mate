import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/controllers/new_task_list_controller.dart';
import 'package:task_mate/controllers/task_status_count_controller.dart';
import 'package:task_mate/core/utils/colors.dart';
import 'package:task_mate/core/utils/progress_indicator.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/features/tasks/widgets/no_task_widget.dart';
import 'package:task_mate/features/tasks/widgets/task_card.dart';
import 'package:task_mate/features/tasks/widgets/task_summery_card.dart';
import 'package:task_mate/features/tasks/screens/add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool isLoading = true;
  final newTaskListController = NewTaskListController.instance;
  final taskStatusCountController = TaskStatusCountController.instance;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    isLoading = true;
    setState(() {});
    await Future.wait([_getTaskStatusCount(), _getNewTaskList()]);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBody() {
    return Visibility(
      visible: !isLoading,
      replacement: const ProgressIndicatorWidget(),
      child: GetBuilder<TaskStatusCountController>(
        builder: (statusCountController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: statusCountController.taskStatusCountList.isEmpty
                ? const NoTaskWidget()
                : SingleChildScrollView(
                    child: GetBuilder<NewTaskListController>(
                      builder: (taskListController) {
                        return Column(
                          children: [
                            const SizedBox(height: 16),
                            _buildSummary(),
                            const SizedBox(height: 10),
                            _buildTaskList(taskListController),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildTaskList(NewTaskListController taskListController) {
    return taskListController.newTaskList.isEmpty
        ? const Column(
            children: [
              SizedBox(height: 48),
              NoTaskWidget(),
            ],
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: taskListController.newTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                task: taskListController.newTaskList[index],
                refreshTaskList: _fetchData,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          );
  }

  Widget _buildSummary() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: taskStatusCountController.taskStatusCountList.map((task) {
          return TaskSummeryCard(
            id: task.id!,
            sum: task.sum!,
          );
        }).toList(),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: primaryColor,
      onPressed: _onTapFloatingActionButton,
      child: const Icon(
        Icons.add_circle_rounded,
        color: Colors.white,
      ),
    );
  }

  Future<void> _onTapFloatingActionButton() async {
    final shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
    if (shouldRefresh == true) {
      _fetchData();
    }
  }

  Future<void> _getNewTaskList() async {
    final result = await newTaskListController.getNewTaskList();
    if (!result) {
      ToastMessage.errorToast(newTaskListController.errorMessage!);
    }
  }

  Future<void> _getTaskStatusCount() async {
    final result = await taskStatusCountController.getTaskStatusCount();
    if (!result) {
      ToastMessage.errorToast(taskStatusCountController.errorMessage!);
    }
  }
}
