import 'package:flutter/material.dart';
import 'package:task_mate/features/home/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_mate/shared/widgets/custom_app_bar.dart';
import 'package:task_mate/shared/widgets/image_background.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(isUpdateProfileScreen: true),
      body: ImageBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Update Profile',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 25),
                _imagePickerContainer(context),
                const SizedBox(height: 15),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: const InputDecoration(hintText: 'First Name'),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: const InputDecoration(hintText: 'Last Name'),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: const InputDecoration(hintText: 'Mobile'),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _onTapAddButton(context),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Update",
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

  Widget _imagePickerContainer(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: 55,
            width: MediaQuery.sizeOf(context).width / 3.5,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "Photos",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapAddButton(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MainBottomNavBarScreen(),
      ),
      (predicate) => false,
    );
  }
}
