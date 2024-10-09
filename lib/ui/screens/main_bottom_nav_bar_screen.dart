import 'package:flutter/material.dart';
import 'package:task_mate/ui/screens/cancelled_screen.dart';
import 'package:task_mate/ui/screens/completed_screen.dart';
import 'package:task_mate/ui/screens/new_task_screen.dart';
import 'package:task_mate/ui/screens/progress_screen.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  int currentIndex = 0;
  List pages = [
    NewTaskScreen(),
    CompletedScreen(),
    CancelledScreen(),
    ProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
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
            label: 'Canceled',
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
