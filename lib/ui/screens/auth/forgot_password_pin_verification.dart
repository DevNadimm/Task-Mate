import 'package:flutter/material.dart';
import 'package:task_mate/ui/screens/auth/set_password.dart';
import 'package:task_mate/ui/screens/auth/sign_in_screen.dart';
import 'package:task_mate/ui/widgets/image_background.dart';

class ForgotPasswordPinVerification extends StatelessWidget {
  const ForgotPasswordPinVerification({super.key});

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
                    "Pin Verification",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 05,
                  ),
                  Text(
                    "A 6-digit verification pin has been sent to your email address.",
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
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SetPassword(),
                          ),
                        );
                      },
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
    return Column(
      children: [
        TextField(
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: const InputDecoration(hintText: 'Email'),
        ),
      ],
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
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInScreen(),
                ),
              );
            },
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
}
