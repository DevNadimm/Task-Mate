import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_mate/data/models/network_response.dart';
import 'package:task_mate/data/services/network_caller.dart';
import 'package:task_mate/data/utils/toast_message.dart';
import 'package:task_mate/data/utils/urls.dart';
import 'package:task_mate/ui/screens/auth/set_password.dart';
import 'package:task_mate/ui/screens/auth/sign_in_screen.dart';
import 'package:task_mate/ui/widgets/image_background.dart';

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
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: ()=> FocusScope.of(context).unfocus(),
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
                      child: Visibility(
                        visible: !inProgress,
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

  Future<void> _recoverVerifyOtp(BuildContext context) async {
    setState(() => inProgress = true);

    final email = widget.email;
    final otp = _pinTEController.text;
    final url = '${Urls.recoverVerifyOtp}$email/$otp';

    NetworkResponse networkResponse = await NetworkCaller.getRequest(url);
    setState(() => inProgress = false);

    if (networkResponse.isSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SetPassword(email: email,otp: otp,),
        ),
      );
      _pinTEController.clear();
    } else {
      ToastMessage.errorToast(networkResponse.errorMessage);
    }
  }

  void _onTapVerify(BuildContext context) {
    if (_globalKey.currentState!.validate()) {
      _recoverVerifyOtp(context);
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
    _pinTEController.dispose();
    super.dispose();
  }
}
