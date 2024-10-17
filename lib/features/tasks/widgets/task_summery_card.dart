import 'package:flutter/material.dart';

class TaskSummeryCard extends StatelessWidget {
  const TaskSummeryCard({super.key, required this.title, required this.count});

  final int count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4.4,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$count',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              FittedBox(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
