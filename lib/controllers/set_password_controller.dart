import 'package:get/get.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/urls.dart';

class SetPasswordController extends GetxController {
  static final instance = Get.find<SetPasswordController>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool isSuccess = false;

  Future<bool> setPassword(String email, String otp, String password) async {
    _inProgress = true;
    update();

    final url = Urls.recoverResetPassword;
    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password,
    };

    NetworkResponse networkResponse =
        await NetworkCaller.postRequest(url: url, body: requestBody);

    if (networkResponse.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = networkResponse.errorMessage;
      isSuccess = false;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
