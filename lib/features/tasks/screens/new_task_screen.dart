import 'package:flutter/material.dart';
import 'package:task_mate/core/utils/colors.dart';
import 'package:task_mate/features/tasks/widgets/task_card.dart';
import 'package:task_mate/features/tasks/widgets/task_summery_card.dart';
import 'package:task_mate/features/tasks/screens/add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
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
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const TaskCard(
                    title: 'Title is here',
                    subTitle:
                        'This is subtitle. when an unknown printer took a galley of type and scrambled it to.',
                    date: 'Date: 02/02/2025',
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

  void _onTapBottomNavBar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
  }
}
