import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_mate/controllers/auth_controller.dart';
import 'package:task_mate/features/auth/screens/sign_in_screen.dart';
import 'package:task_mate/features/home/screens/main_bottom_nav_bar_screen.dart';
import '../../../shared/widgets/image_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _goToNextScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/splash_icon.svg',
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              const SizedBox(height: 15),
              const Text(
                "Welcome to\nTaskMate",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToNextScreen(context) async {
    await Future.delayed(const Duration(seconds: 3));
    await AuthController.getAccessToken();
    if (AuthController.isSignedIn()) {
      AuthController.getUserData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainBottomNavBarScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        ),
      );
    }
  }
}
