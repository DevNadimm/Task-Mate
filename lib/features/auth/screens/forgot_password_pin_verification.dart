import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_mate/controllers/pin_verification_controller.dart';
import 'package:task_mate/core/utils/colors.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/features/auth/screens/set_password.dart';
import 'package:task_mate/features/auth/screens/sign_in_screen.dart';
import 'package:task_mate/shared/widgets/image_background.dart';

class ForgotPasswordPinVerification extends StatefulWidget {
  const ForgotPasswordPinVerification({super.key, required this.email});

  final String email;

  @override
  State<ForgotPasswordPinVerification> createState() =>
      _ForgotPasswordPinVerificationState();
}

class _ForgotPasswordPinVerificationState
    extends State<ForgotPasswordPinVerification> {
  final TextEditingController _pinTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

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
                      "Pin Verification",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "A 6-digit verification pin has been sent to your email address.",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    _pinField(context),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<PinVerificationController>(
                        builder: (controller) {
                          return Visibility(
                            visible: !controller.inProgress,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: () => _onTapVerify(context),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  'Verify',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.white),
                                ),
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

  Widget _pinField(BuildContext context) {
    return Form(
      key: _globalKey,
      child: PinCodeTextField(
        controller: _pinTEController,
        length: 6,
        obscureText: false,
        keyboardType: TextInputType.number,
        animationType: AnimationType.fade,
        backgroundColor: Colors.transparent,
        autoDisposeControllers: false,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          inactiveFillColor: Colors.white,
          inactiveColor: Colors.grey,
          selectedFillColor: Colors.grey,
          selectedColor: Colors.grey,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        appContext: context,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pin cannot be empty';
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

  Future<void> _recoverVerifyOtp(BuildContext context) async {
    final email = widget.email;
    final otp = _pinTEController.text;
    final url = '${Urls.recoverVerifyOtp}$email/$otp';

    final controller = PinVerificationController.instance;
    final result = await controller.recoverVerifyOtp(url);

    if (result) {
      Get.off(SetPassword(email: email, otp: otp));
      _pinTEController.clear();
    } else {
      ToastMessage.errorToast(controller.errorMessage!);
    }
  }

  void _onTapVerify(BuildContext context) {
    if (_globalKey.currentState!.validate()) {
      _recoverVerifyOtp(context);
    }
  }

  @override
  void dispose() {
    _pinTEController.dispose();
    super.dispose();
  }
}
