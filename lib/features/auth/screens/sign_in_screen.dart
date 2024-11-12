import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/controllers/sign_in_controller.dart';
import 'package:task_mate/core/utils/colors.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/features/auth/screens/forgot_password_email_address_screen.dart';
import 'package:task_mate/features/auth/screens/sign_up_screen.dart';
import 'package:task_mate/features/home/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_mate/shared/widgets/image_background.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ImageBackground(
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
                      child: GetBuilder<SignInController>(
                        builder: (controller) {
                          return Visibility(
                            visible: !controller.inProgress,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: () => _onTapSignIn(context),
                              child: const Padding(
                                padding: EdgeInsets.all(12),
                                child: Icon(Icons.double_arrow),
                              ),
                            ),
                          );
                        },
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
      ),
    );
  }

  Widget _textFields(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.bodyLarge,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (email) {
              if (email == null || email.isEmpty) {
                return 'Please enter your email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _passwordTEController,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: const InputDecoration(hintText: 'Password'),
            validator: (password) {
              if (password == null || password.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Get.off(const ForgotPasswordEmailAddressScreen()),
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
                'Don\'t have an account? ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              GestureDetector(
                onTap: () => Get.off(const SignUpScreen()),
                child: Text(
                  'Sign Up',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    final controller = SignInController.instance;
    final result = await controller.signIn(
      _emailTEController.text.trim(),
      _passwordTEController.text.trim(),
    );

    if (result) {
      ToastMessage.successToast('Sign in successful!');
      _clearFields();
      Get.offAll(MainBottomNavBarScreen());
    } else {
      ToastMessage.errorToast(controller.errorMessage!);
    }
  }

  void _clearFields() {
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  void _onTapSignIn(BuildContext context) {
    if (_globalKey.currentState!.validate()) {
      _signIn();
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
