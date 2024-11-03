import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_mate/controllers/auth_controller.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/toast_message.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/features/home/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_mate/models/user_model.dart';
import 'package:task_mate/shared/widgets/custom_app_bar.dart';
import 'package:task_mate/shared/widgets/image_background.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool updateProfileInProgress = false;
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }

  void _initializeFormData() {
    _emailTEController.text = AuthController.userModel?.email ?? '';
    _firstNameTEController.text = AuthController.userModel?.firstName ?? '';
    _lastNameTEController.text = AuthController.userModel?.lastName ?? '';
    _mobileTEController.text = AuthController.userModel?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(isUpdateProfileScreen: true),
      body: ImageBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 25),
                  _imagePickerContainer(context),
                  const SizedBox(height: 15),
                  _buildTextFormField(
                    controller: _emailTEController,
                    label: 'Email',
                    enabled: false,
                  ),
                  const SizedBox(height: 15),
                  _buildTextFormField(
                    controller: _firstNameTEController,
                    label: 'First Name',
                  ),
                  const SizedBox(height: 15),
                  _buildTextFormField(
                    controller: _lastNameTEController,
                    label: 'Last Name',
                  ),
                  const SizedBox(height: 15),
                  _buildTextFormField(
                    controller: _mobileTEController,
                    label: 'Mobile',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordTEController,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(height: 15),
                  _buildUpdateButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    bool enabled = true,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(hintText: label),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label cannot be empty';
        }
        return null;
      },
    );
  }

  Widget _imagePickerContainer(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0XFF44494f),
            radius: 53,
            child: CircleAvatar(
              backgroundImage: _selectedImage != null
                  ? FileImage(File(_selectedImage!.path))
                  : AuthController.userModel?.photo != null
                      ? MemoryImage(base64Decode(AuthController.userModel!.photo!))
                      : const AssetImage('assets/images/avatar.jpeg') as ImageProvider,
              radius: 50,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: const CircleAvatar(
                backgroundColor: Color(0XFF44494f),
                radius: 17,
                child: Icon(
                  CupertinoIcons.photo,
                  color: Colors.white,
                  size: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  Widget _buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      child: Visibility(
        visible: !updateProfileInProgress,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ElevatedButton(
          onPressed: _onTapUpdateButton,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Update",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapUpdateButton() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      updateProfileInProgress = true;
    });

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };

    if (_passwordTEController.text.isNotEmpty) {
      requestBody["password"] = _passwordTEController.text.trim();
    }

    if (_selectedImage != null) {
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      requestBody["photo"] = convertedImage;
    }

    NetworkResponse networkResponse = await NetworkCaller.postRequest(
      url: Urls.getProfileUpdate,
      body: requestBody,
    );

    setState(() {
      updateProfileInProgress = false;
    });

    if (networkResponse.isSuccess) {
      UserModel userModel = UserModel.fromJson(requestBody);
      AuthController.saveUserData(userModel);
      debugPrint("Image Base64: ${AuthController.userModel!.photo}");
      ToastMessage.successToast("Profile updated");
    } else {
      ToastMessage.errorToast(networkResponse.errorMessage);
    }
  }
}
