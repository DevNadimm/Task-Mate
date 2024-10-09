import 'package:flutter/material.dart';
import 'package:task_mate/ui/screens/auth/forgot_password_email_address.dart';
import 'package:task_mate/ui/screens/auth/sign_up_screen.dart';
import 'package:task_mate/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_mate/ui/widgets/image_background.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ImageBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Get Started With",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 25),
                  _textFields(context),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _onTapSignIn(context),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.double_arrow),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  _buildBottomSection(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFields(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: Theme.of(context).textTheme.bodyLarge,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'Email'),
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: const InputDecoration(hintText: 'Password'),
        ),
      ],
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _onTapForgotPassword(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Forgot Password?',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have account? ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              GestureDetector(
                onTap: () => _onTapSignUp(context),
                child: Text(
                  'Sign Up',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onTapSignIn(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainBottomNavBarScreen(),
      ),
    );
  }

  void _onTapSignUp(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  void _onTapForgotPassword(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordEmailAddress(),
      ),
    );
  }
}
