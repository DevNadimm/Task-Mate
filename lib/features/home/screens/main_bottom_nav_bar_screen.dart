import 'package:flutter/material.dart';
import 'package:task_mate/features/tasks/screens/cancelled_task_screen.dart';
import 'package:task_mate/features/tasks/screens/completed_task_screen.dart';
import 'package:task_mate/features/tasks/screens/new_task_screen.dart';
import 'package:task_mate/features/tasks/screens/progress_task_screen.dart';
import 'package:task_mate/shared/widgets/custom_app_bar.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  int currentIndex = 0;
  final List _screens = [
    const NewTaskScreen(),
    const CompletedTaskScreen(),
    const CancelledTaskScreen(),
    const ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: ((index) {
          currentIndex = index;
          setState(() {});
        }),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.circle_outlined),
            selectedIcon: Icon(Icons.circle),
            label: 'New Task',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            selectedIcon: Icon(Icons.cancel),
            label: 'Cancelled',
          ),
          NavigationDestination(
            icon: Icon(Icons.pending_outlined),
            selectedIcon: Icon(Icons.pending),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}
