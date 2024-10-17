import 'package:flutter/material.dart';
import 'package:task_mate/features/tasks/widgets/task_card.dart';

class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({super.key});

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
                // return TaskCard();
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
