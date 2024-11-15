import 'package:get/get.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/urls.dart';

class AddNewTaskController extends GetxController {
  static final instance = Get.find<AddNewTaskController>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool isSuccess = false;

  Future<bool> addNawPost({required String title, required String description}) async {
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };
    NetworkResponse networkResponse = await NetworkCaller.postRequest(
      url: Urls.createTask,
      body: requestBody,
    );

    if (networkResponse.isSuccess) {
      isSuccess = true;
    } else {
      isSuccess = false;
      _errorMessage = networkResponse.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
