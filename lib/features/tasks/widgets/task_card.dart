import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/colors.dart';
import 'package:task_mate/core/utils/date.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/models/task_model.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.refreshTaskList,
  });

  final TaskModel task;
  final VoidCallback refreshTaskList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? 'No Title',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            ReadMoreText(
              widget.task.description ?? 'No Description',
              trimMode: TrimMode.Line,
              trimLines: 3,
              trimCollapsedText: ' See More',
              trimExpandedText: ' See Less',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.black.withOpacity(0.7),
                  ),
              moreStyle: Theme.of(context).textTheme.titleMedium,
              lessStyle: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 5),
            Text(
              DateFormater.formatDate(widget.task.createdDate!),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            _buildRowSection(
              context: context,
              refreshTaskList: widget.refreshTaskList,
              task: widget.task,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapEditButton(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Update Task Status',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['New', 'Completed', 'Cancelled', 'Progress'].map(
              (status) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ListTile(
                    title: Text(
                      status,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    leading: Icon(
                      _getStatusIcon(status),
                      color: _getStatusColor(status),
                    ),
                    tileColor: primaryColor.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onTap: () {
                      _getUpdateTask(
                        id: widget.task.id.toString(),
                        status: status,
                        refreshTaskList: widget.refreshTaskList,
                      );
                    },
                  ),
                );
              },
            ).toList(),
          ),
          actionsPadding: const EdgeInsets.only(right: 12, bottom: 8),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 1, color: Colors.black26),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getDeleteTask({
    required String id,
    required VoidCallback refreshTaskList,
  }) async {
    final url = "${Urls.getDeleteTask}$id";
    NetworkResponse networkResponse = await NetworkCaller.getRequest(url);
    if (networkResponse.isSuccess) {
      ToastMessage.successToast("Task deleted successfully");
      refreshTaskList();
    } else {
      ToastMessage.errorToast(
        "Failed to delete task: ${networkResponse.errorMessage}",
      );
    }
  }

  Future<void> _getUpdateTask({
    required String id,
    required String status,
    required VoidCallback refreshTaskList,
  }) async {
    final url = "${Urls.getUpdateTaskStatus}$id/$status";
    NetworkResponse networkResponse = await NetworkCaller.getRequest(url);
    if (networkResponse.isSuccess) {
      ToastMessage.successToast("Status updated successfully");
      refreshTaskList();
      Navigator.pop(context);
    } else {
      ToastMessage.errorToast(
        "Failed to update status: ${networkResponse.errorMessage}",
      );
    }
  }

  Widget _buildRowSection({
    required BuildContext context,
    required TaskModel task,
    required VoidCallback refreshTaskList,
  }) {
    return Row(
      children: [
        Chip(
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              task.status.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          backgroundColor: _getStatusColor(task.status.toString()),
          side: BorderSide.none,
        ),
        const Spacer(),
        IconButton(
          onPressed: () => _onTapEditButton(context),
          icon: Icon(
            Icons.edit_note_rounded,
            color: primaryColor,
          ),
        ),
        IconButton(
          onPressed: () {
            _getDeleteTask(
              id: task.id.toString(),
              refreshTaskList: refreshTaskList,
            );
          },
          icon: const Icon(
            Icons.delete_sweep_outlined,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'New':
        return Icons.fiber_new_rounded;
      case 'Completed':
        return Icons.check_circle_rounded;
      case 'Cancelled':
        return Icons.cancel_rounded;
      case 'Progress':
        return Icons.pending;
      default:
        return Icons.info;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'New':
        return Colors.blueAccent;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.redAccent;
      case 'Progress':
        return Colors.orangeAccent;
      default:
        return Colors.grey;
    }
  }
}
