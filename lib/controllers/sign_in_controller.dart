import 'package:get/get.dart';
import 'package:task_mate/controllers/auth_controller.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/models/login_model.dart';

class SignInController extends GetxController {
  static final instance = Get.find<SignInController>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool isSuccess = false;

  Future<bool> signIn(String email, String password) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };

    NetworkResponse networkResponse = await NetworkCaller.postRequest(
      url: Urls.login,
      body: requestBody,
    );

    if (networkResponse.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(networkResponse.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);
      AuthController.getUserData();
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
