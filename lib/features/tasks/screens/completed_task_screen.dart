import 'package:flutter/material.dart';
import 'package:task_mate/features/tasks/widgets/task_card.dart';

class CompletedTaskScreen extends StatelessWidget {
  const CompletedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
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
    );
  }
}
