import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/core/utils/colors.dart';
import 'package:task_mate/controllers/auth_controller.dart';
import 'package:task_mate/features/auth/screens/update_profile_screen.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

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

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      title: GestureDetector(
        onTap: () => _onTapProfile(context),
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

  void loadUserData() {
    setState(() {
      photo = AuthController.userModel?.photo;
      fullName = AuthController.userModel?.fullName;
      email = AuthController.userModel?.email;
    });
  }

  void _onTapProfile(BuildContext context) {
    Get.to(const UpdateProfileScreen())!.then((_) => loadUserData());
  }
}
