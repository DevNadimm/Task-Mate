import 'package:flutter/material.dart';
import 'package:task_mate/ui/screens/add_new_task_screen.dart';
import 'package:task_mate/ui/widgets/task_summery_card.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TaskSummeryCard(title: 'New', count: 09),
                TaskSummeryCard(title: 'Completed', count: 09),
                TaskSummeryCard(title: 'Cancelled', count: 09),
                TaskSummeryCard(title: 'Progress ', count: 09),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onTapBottomNavBar(context),
        child: const Icon(Icons.add_circle_rounded),
      ),
    );
  }

  void _onTapBottomNavBar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
  }
}
