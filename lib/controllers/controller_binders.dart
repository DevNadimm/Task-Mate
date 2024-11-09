import 'package:get/get.dart';
import 'package:task_mate/controllers/sign_in_controller.dart';

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(
      SignInController(),
    );
  }
}
