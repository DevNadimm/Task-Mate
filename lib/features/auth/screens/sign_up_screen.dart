import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/controllers/sign_up_controller.dart';
import 'package:task_mate/core/utils/colors.dart';
import 'package:task_mate/core/utils/progress_indicator.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/features/auth/screens/sign_in_screen.dart';
import 'package:task_mate/shared/widgets/image_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
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
                      "Join With Us",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 25),
                    _textFields(context),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<SignUpController>(
                        builder: (controller) {
                          return Visibility(
                            visible: !controller.inProgress,
                            replacement: const ProgressIndicatorWidget(),
                            child: ElevatedButton(
                              onPressed: () => _onTapSignUp(context),
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
            controller: _firstNameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: const InputDecoration(hintText: 'First Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _lastNameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: const InputDecoration(hintText: 'Last Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _emailTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.bodyLarge,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (email) {
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
              if (email!.isEmpty) {
                return 'Please enter your email address';
              } else if (!emailRegex.hasMatch(email)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _mobileTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.bodyLarge,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(hintText: 'Mobile'),
            validator: (mobile) {
              if (mobile!.isEmpty) {
                return 'Please enter your mobile number';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _passwordTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: const InputDecoration(hintText: 'Password'),
            obscureText: true,
            validator: (password) {
              final passwordRegex =
                  RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@#$%^&+=!]{6,}$');
              if (password!.isEmpty) {
                return 'Please enter a strong password';
              } else if (!passwordRegex.hasMatch(password)) {
                return 'At least 6 characters with letters and numbers.';
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Have an account? ',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          GestureDetector(
            onTap: () => Get.off(const SignInScreen()),
            child: Text(
              'Sign In',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signUp() async {
    final controller = SignUpController.instance;
    final result = await controller.signUp(
      _emailTEController.text.trim(),
      _firstNameTEController.text.trim(),
      _lastNameTEController.text.trim(),
      _mobileTEController.text.trim(),
      _passwordTEController.text.trim(),
    );

    if (result) {
      ToastMessage.successToast('Sign up successful!');
      _clearField();
      Get.off(const SignInScreen());
    } else {
      ToastMessage.errorToast(controller.errorMessage!);
    }
  }

  void _clearField() {
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _emailTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  void _onTapSignUp(BuildContext context) {
    if (_globalKey.currentState!.validate()) {
      _signUp();
    }
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
