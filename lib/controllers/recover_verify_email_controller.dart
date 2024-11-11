import 'package:get/get.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';

class RecoverVerifyEmail extends GetxController {
  static final instance = Get.find<RecoverVerifyEmail>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool isSuccess = false;

  Future<bool> recoverVerifyEmail(String url) async {
    _inProgress = true;
    update();

    NetworkResponse networkResponse = await NetworkCaller.getRequest(url);

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