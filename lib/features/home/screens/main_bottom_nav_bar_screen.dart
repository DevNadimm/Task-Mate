import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/controllers/bottom_nav_controller.dart';
import 'package:task_mate/core/utils/colors.dart';
import 'package:task_mate/features/tasks/screens/cancelled_task_screen.dart';
import 'package:task_mate/features/tasks/screens/completed_task_screen.dart';
import 'package:task_mate/features/tasks/screens/new_task_screen.dart';
import 'package:task_mate/features/tasks/screens/progress_task_screen.dart';
import 'package:task_mate/shared/widgets/custom_app_bar.dart';

class MainBottomNavBarScreen extends StatelessWidget {
  MainBottomNavBarScreen({super.key});

  final List<Widget> _screens = [
    const NewTaskScreen(),
    const CompletedTaskScreen(),
    const CancelledTaskScreen(),
    const ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const CustomAppBar(),
      body: GetBuilder<BottomNavController>(
        builder: (controller) => _screens[controller.currentIndex],
      ),
      bottomNavigationBar: GetBuilder<BottomNavController>(
        builder: (controller) => NavigationBar(
          selectedIndex: controller.currentIndex,
          backgroundColor: backgroundColor,
          onDestinationSelected: (index) {
            controller.changeIndex(index);
          },
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
      ),
    );
  }
}
