import 'package:get/get.dart';
import 'package:task_mate/controllers/pin_verification_controller.dart';
import 'package:task_mate/controllers/recover_verify_email_controller.dart';
import 'package:task_mate/controllers/set_password_controller.dart';
import 'package:task_mate/controllers/sign_in_controller.dart';
import 'package:task_mate/controllers/sign_up_controller.dart';

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(RecoverVerifyEmailController());
    Get.put(PinVerificationController());
    Get.put(SetPasswordController());
  }
}
