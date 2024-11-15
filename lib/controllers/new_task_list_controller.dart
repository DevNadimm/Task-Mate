import 'package:get/get.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/models/task_list_model.dart';
import 'package:task_mate/models/task_model.dart';

class NewTaskListController extends GetxController {
  static final instance = Get.find<NewTaskListController>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool isSuccess = false;

  List<TaskModel> _newTaskList = [];
  List<TaskModel> get newTaskList => _newTaskList;

  Future<bool> getNewTaskList() async {
    _inProgress = true;
    _errorMessage = null;
    update();

    NetworkResponse networkResponse =
        await NetworkCaller.getRequest(Urls.getNewTask);

    if (networkResponse.isSuccess) {
      _newTaskList.clear();
      final taskListModel = TaskListModel.fromJson(networkResponse.responseData);
      _newTaskList = taskListModel.taskList ?? [];
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
