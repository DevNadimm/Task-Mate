import 'package:flutter/material.dart';
import 'package:task_mate/utils/colors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.date});

  final String title;
  final String subTitle;
  final String date;

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
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 05),
            Text(
              widget.subTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 05),
            Text(
              widget.date,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            _buildRowSection(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildRowSection(BuildContext context){
  return Row(
    children: [
      Chip(
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'New',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500, color: Colors.white),
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
        onPressed: () {},
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
