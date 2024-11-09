import 'package:get/get.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/urls.dart';

class SignUpController extends GetxController {
  static final instance = Get.find<SignUpController>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool isSuccess = false;

  Future<bool> signUp(
      String email, firstName, lastName, mobile, password) async {
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };

    NetworkResponse networkResponse = await NetworkCaller.postRequest(
      url: Urls.registration,
      body: requestBody,
    );

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
