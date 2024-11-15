import 'package:get/get.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/models/task_status_count_model.dart';
import 'package:task_mate/models/task_status_model.dart';

class TaskStatusCountController extends GetxController {
  static final instance = Get.find<TaskStatusCountController>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool isSuccess = false;

  List<TaskStatusModel> _taskStatusCountList = [];
  List<TaskStatusModel> get taskStatusCountList => _taskStatusCountList;

  Future<bool> getTaskStatusCount() async {
    _inProgress = true;
    _errorMessage = null;
    update();

    NetworkResponse networkResponse =
        await NetworkCaller.getRequest(Urls.getTaskStatusCount);

    if (networkResponse.isSuccess) {
      _taskStatusCountList.clear();
      final taskStatusCount =
          TaskStatusCountModel.fromJson(networkResponse.responseData);
      _taskStatusCountList = taskStatusCount.taskStatusCountList ?? [];
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
