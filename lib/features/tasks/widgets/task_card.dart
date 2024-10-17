import 'package:flutter/material.dart';
import 'package:task_mate/core/utils/colors.dart';
import 'package:task_mate/models/task_model.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? '',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 05),
            Text(
              widget.task.description ?? '',
              style: Theme.of(context).textTheme.bodyLarge!,
            ),
            const SizedBox(height: 05),
            Text(
              'Date: ${widget.task.createdDate}' ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            _buildRowSection(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildRowSection(BuildContext context) {
  return Row(
    children: [
      Chip(
        label: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'New',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        backgroundColor: Colors.blue,
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
        onPressed: () {},
        icon: const Icon(
          Icons.delete_sweep_outlined,
          color: Colors.red,
        ),
      ),
    ],
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
          'Edit Status',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['New', 'Completed', 'Cancelled', 'Progress'].map(
            (status) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListTile(
                  title: Text(status,
                      style: Theme.of(context).textTheme.titleLarge),
                  leading: Icon(
                    _getStatusIcon(status),
                    color: _getStatusColor(status),
                  ),
                  tileColor: Colors.green.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onTap: () {},
                ),
              );
            },
          ).toList(),
        ),
        actionsPadding: const EdgeInsets.only(right: 12, bottom: 8),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Confirm'),
          ),
        ],
      );
    },
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
