import 'package:flutter/material.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/controllers/auth_controller.dart';
import 'package:task_mate/features/auth/screens/forgot_password_email_address.dart';
import 'package:task_mate/features/auth/screens/sign_up_screen.dart';
import 'package:task_mate/features/home/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_mate/models/login_model.dart';
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
  bool inProgress = false;

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
                      child: Visibility(
                        visible: !inProgress,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed:
                              inProgress ? null : () => _onTapSignIn(context),
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.double_arrow),
                          ),
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
                'Don\'t have an account? ',
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

  Future<void> _signIn() async {
    setState(() => inProgress = true);

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text.trim(),
    };

    NetworkResponse networkResponse = await NetworkCaller.postRequest(
      url: Urls.login,
      body: requestBody,
    );

    setState(() => inProgress = false);

    if (networkResponse.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(networkResponse.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);
      AuthController.getUserData();
      ToastMessage.successToast('Sign in successful!');
      _clearFields();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainBottomNavBarScreen(),
        ),
      );
    } else {
      ToastMessage.errorToast(networkResponse.errorMessage);
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

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
