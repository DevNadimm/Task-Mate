import 'package:flutter/material.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/shared/widgets/custom_app_bar.dart';
import 'package:task_mate/shared/widgets/image_background.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool _inProgress = false;
  bool _shouldRefreshPrevPage = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Navigator.pop(context, _shouldRefreshPrevPage);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ImageBackground(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Add New Task',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 25),
                    _buildTextFields(),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: !_inProgress,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () => onTapAddButton(context),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "Add",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return Form(
      key: _globalKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleTEController,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: const InputDecoration(hintText: 'Title'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _descriptionTEController,
            maxLines: 4,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: const InputDecoration(hintText: 'Description'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Future<void> _addNawPost() async {
    setState(() => _inProgress = true);

    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New"
    };
    NetworkResponse networkResponse = await NetworkCaller.postRequest(
        url: Urls.createTask, body: requestBody);

    setState(() => _inProgress = false);

    if (networkResponse.isSuccess) {
      ToastMessage.successToast('Task added successfully!');
      _shouldRefreshPrevPage = true;

      _titleTEController.clear();
      _descriptionTEController.clear();
    } else {
      ToastMessage.errorToast(networkResponse.errorMessage);
    }
  }

  void onTapAddButton(BuildContext context) {
    if (_globalKey.currentState!.validate()) {
      _addNawPost();
    }
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
