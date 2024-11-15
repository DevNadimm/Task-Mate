import 'package:get/get.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/models/task_list_model.dart';
import 'package:task_mate/models/task_model.dart';

class CancelledTaskListController extends GetxController {
  static final instance = Get.find<CancelledTaskListController>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool isSuccess = false;

  List<TaskModel> _cancelledTaskList = [];
  List<TaskModel> get cancelledTaskList => _cancelledTaskList;

  Future<bool> getCancelledTaskList() async {
    _inProgress = true;
    update();

    NetworkResponse networkResponse =
        await NetworkCaller.getRequest(Urls.getCancelledTask);

    if (networkResponse.isSuccess) {
      _cancelledTaskList.clear();
      final taskListModel =
          TaskListModel.fromJson(networkResponse.responseData);
      _cancelledTaskList = taskListModel.taskList ?? [];
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
