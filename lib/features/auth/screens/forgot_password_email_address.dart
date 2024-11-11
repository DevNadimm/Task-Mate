import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/controllers/recover_verify_email_controller.dart';
import 'package:task_mate/core/utils/colors.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/features/auth/screens/forgot_password_pin_verification.dart';
import 'package:task_mate/features/auth/screens/sign_in_screen.dart';
import 'package:task_mate/shared/widgets/image_background.dart';

class ForgotPasswordEmailAddress extends StatefulWidget {
  const ForgotPasswordEmailAddress({super.key});

  @override
  State<ForgotPasswordEmailAddress> createState() =>
      _ForgotPasswordEmailAddressState();
}

class _ForgotPasswordEmailAddressState
    extends State<ForgotPasswordEmailAddress> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _emailTEController = TextEditingController();

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
                      "Your Email Address",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(
                      height: 05,
                    ),
                    Text(
                      "A 6-digit verification pin will be sent to your email address.",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _textField(context),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<RecoverVerifyEmail>(
                        builder: (controller) {
                          return Visibility(
                            visible: !controller.inProgress,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: () => _onTapNextButton(context),
                              child: const Padding(
                                padding: EdgeInsets.all(12),
                                child: Icon(Icons.double_arrow),
                              ),
                            ),
                          );
                        },
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
      ),
    );
  }

  Widget _textField(BuildContext context) {
    return Form(
      key: _globalKey,
      child: TextFormField(
        controller: _emailTEController,
        style: Theme.of(context).textTheme.bodyLarge,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(hintText: 'Email'),
        validator: (email) {
          if (email == null || email.isEmpty) {
            return 'Please enter your email address';
          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
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

  Future<void> _recoverVerifyEmail(BuildContext context) async {
    String email = _emailTEController.text.trim();
    final url = '${Urls.recoverVerifyEmail}$email';

    final controller = RecoverVerifyEmail.instance;
    final result = await controller.recoverVerifyEmail(url);

    if (result) {
      Get.off(ForgotPasswordPinVerification(email: email));
      _emailTEController.clear();
    } else {
      ToastMessage.errorToast(controller.errorMessage!);
    }
  }

  void _onTapNextButton(BuildContext context) {
    if (_globalKey.currentState!.validate()) {
      _recoverVerifyEmail(context);
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
