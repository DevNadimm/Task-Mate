import 'package:flutter/material.dart';
import 'package:task_mate/features/tasks/widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
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
                // return TaskCard(
                //
                // );
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
