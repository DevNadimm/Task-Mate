import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/controllers/add_new_task_controller.dart';
import 'package:task_mate/core/utils/progress_indicator.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/shared/widgets/custom_app_bar.dart';
import 'package:task_mate/shared/widgets/image_background.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
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
                    child: GetBuilder<AddNewTaskController>(
                      builder: (controller) {
                        return Visibility(
                          visible: !controller.inProgress,
                          replacement: const ProgressIndicatorWidget(),
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
                        );
                      },
                    ),
                  )
                ],
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
    final controller = AddNewTaskController.instance;
    final result = await controller.addNawPost(
      title: _titleTEController.text.trim(),
      description: _descriptionTEController.text.trim(),
    );

    if (result) {
      ToastMessage.successToast('Task added successfully!');
      _titleTEController.clear();
      _descriptionTEController.clear();
    } else {
      ToastMessage.errorToast(controller.errorMessage!);
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
