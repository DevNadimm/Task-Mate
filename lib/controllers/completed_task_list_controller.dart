import 'package:get/get.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/models/task_list_model.dart';
import 'package:task_mate/models/task_model.dart';

class CompletedTaskListController extends GetxController {
  static final instance = Get.find<CompletedTaskListController>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool isSuccess = false;

  List<TaskModel> _completedTaskList = [];
  List<TaskModel> get completedTaskList => _completedTaskList;

  Future<bool> getCancelledTaskList() async {
    _inProgress = true;
    update();

    NetworkResponse networkResponse =
        await NetworkCaller.getRequest(Urls.getCompletedTask);

    if (networkResponse.isSuccess) {
      _completedTaskList.clear();
      final taskListModel =
          TaskListModel.fromJson(networkResponse.responseData);
      _completedTaskList = taskListModel.taskList ?? [];
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
