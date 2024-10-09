import 'package:flutter/material.dart';
import 'package:task_mate/ui/screens/add_new_task_screen.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: const Center(
          child: Text('New Task'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onTapBottomNavBar(context),
          child: const Icon(Icons.add_circle_rounded),
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
