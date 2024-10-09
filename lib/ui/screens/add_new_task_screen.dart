import 'package:flutter/material.dart';
import 'package:task_mate/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_mate/ui/widgets/custom_app_bar.dart';

class AddNewTaskScreen extends StatelessWidget {
  const AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Task',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 25),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: const InputDecoration(hintText: 'Title'),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  maxLines: 4,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: const InputDecoration(hintText: 'Description'),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => onTapAddButton(context),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Add",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapAddButton(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MainBottomNavBarScreen(),
      ),
      (predicate) => false,
    );
  }
}
