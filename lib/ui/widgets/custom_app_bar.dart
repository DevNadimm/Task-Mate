import 'package:flutter/material.dart';
import 'package:task_mate/data/utils/colors.dart';
import 'package:task_mate/data/utils/toast_message.dart';
import 'package:task_mate/ui/controller/auth_controller.dart';
import 'package:task_mate/ui/screens/auth/sign_in_screen.dart';
import 'package:task_mate/ui/screens/update_profile_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, this.isUpdateProfileScreen = false});

  bool isUpdateProfileScreen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      title: GestureDetector(
        onTap: () => isUpdateProfileScreen ? null : _onTapProfile(context),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: primaryColor.withOpacity(0.2),
              backgroundImage: const NetworkImage(
                  'https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg'),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Test User',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'test@gmail.com',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        if (isUpdateProfileScreen)
          IconButton(
            onPressed: () => _onTapLogOut(context),
            icon: const Icon(Icons.logout),
          ),
      ],
      backgroundColor: primaryColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

void _onTapProfile(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const UpdateProfileScreen(),
    ),
  );
}

void _onTapLogOut(BuildContext context) {
  AuthController.clearAccessToken();
  ToastMessage.successToast('Sign out successful!');
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => const SignInScreen(),
    ),
    (predicate) => false,
  );
}
