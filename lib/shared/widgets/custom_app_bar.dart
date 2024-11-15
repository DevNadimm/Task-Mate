import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_mate/core/utils/colors.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/controllers/auth_controller.dart';
import 'package:task_mate/features/auth/screens/sign_in_screen.dart';
import 'package:task_mate/features/auth/screens/update_profile_screen.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.isUpdateProfileScreen = false});

  final bool isUpdateProfileScreen;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? photo;
  String? fullName;
  String? email;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() {
    setState(() {
      photo = AuthController.userModel?.photo;
      fullName = AuthController.userModel?.fullName;
      email = AuthController.userModel?.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: foregroundColor,
      title: GestureDetector(
        onTap: () => widget.isUpdateProfileScreen ? null : _onTapProfile(context),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: backgroundColor.withOpacity(0.2),
              backgroundImage: AuthController.userModel?.photo != null
                  ? MemoryImage(base64Decode(AuthController.userModel!.photo!))
                  : const AssetImage('assets/images/avatar.jpeg'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName ?? 'No Name Available',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: foregroundColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  email ?? 'No Email Available',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: foregroundColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        if (widget.isUpdateProfileScreen)
          IconButton(
            onPressed: () => _onTapLogOut(context),
            icon: const Icon(Icons.logout),
          ),
      ],
      backgroundColor: backgroundColor,
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          height: 1.0,
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
    );
  }

  void _onTapProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UpdateProfileScreen(),
      ),
    ).then((_) => loadUserData());
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
}
