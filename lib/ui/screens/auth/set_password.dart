import 'package:flutter/material.dart';
import 'package:task_mate/data/models/network_response.dart';
import 'package:task_mate/data/services/network_caller.dart';
import 'package:task_mate/data/utils/toast_message.dart';
import 'package:task_mate/data/utils/urls.dart';
import 'package:task_mate/ui/screens/auth/sign_in_screen.dart';
import 'package:task_mate/ui/widgets/image_background.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  bool inProgress = false;

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
                    "Set Password",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 05,
                  ),
                  Text(
                    "Minimum length password: 6 characters with a combination of letters and numbers.",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _textFields(context),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: !inProgress,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () => _onTapConfirmButton(context),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            'Confirm',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
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
    return Form(
      key: _globalKey,
      child: Column(
        children: [
          TextFormField(
            controller: _passwordTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: const InputDecoration(hintText: 'Password'),
            obscureText: true,
            validator: (value) {
              final passwordRegex =
                  RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@#$%^&+=!]{6,}$');
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              } else if (!passwordRegex.hasMatch(value)) {
                return 'At least 6 characters with letters and numbers.';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _confirmPasswordTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: const InputDecoration(hintText: 'Confirm Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              } else if (value != _passwordTEController.text.trim()) {
                return 'Passwords do not match';
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
            'Have account? ',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          GestureDetector(
            onTap: () => _onTapSignIn(context),
            child: Text(
              'Sign In',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmPassword(BuildContext context) async {
    setState(() => inProgress = true);

    final url = Urls.recoverResetPassword;
    Map<String, dynamic> requestBody = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _passwordTEController.text.trim()
    };

    NetworkResponse networkResponse =
        await NetworkCaller.postRequest(url: url, body: requestBody);

    setState(() => inProgress = false);

    if (networkResponse.isSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );

      _passwordTEController.clear();
      _confirmPasswordTEController.clear();
    } else {
      ToastMessage.errorToast(networkResponse.errorMessage);
    }
  }

  void _onTapConfirmButton(BuildContext context) {
    if (_globalKey.currentState!.validate()) {
      _confirmPassword(context);
    }
  }

  void _onTapSignIn(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
