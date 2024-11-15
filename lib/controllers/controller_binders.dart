import 'package:get/get.dart';
import 'package:task_mate/controllers/add_new_task_controller.dart';
import 'package:task_mate/controllers/bottom_nav_controller.dart';
import 'package:task_mate/controllers/new_task_list_controller.dart';
import 'package:task_mate/controllers/pin_verification_controller.dart';
import 'package:task_mate/controllers/recover_verify_email_controller.dart';
import 'package:task_mate/controllers/set_password_controller.dart';
import 'package:task_mate/controllers/sign_in_controller.dart';
import 'package:task_mate/controllers/sign_up_controller.dart';
import 'package:task_mate/controllers/task_status_count_controller.dart';
import 'package:task_mate/controllers/update_profile_controller.dart';

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(RecoverVerifyEmailController());
    Get.put(PinVerificationController());
    Get.put(SetPasswordController());
    Get.put(BottomNavController());
    Get.put(UpdateProfileController());
    Get.put(AddNewTaskController());
    Get.put(NewTaskListController());
    Get.put(TaskStatusCountController());
  }
}
