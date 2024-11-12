import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_mate/controllers/auth_controller.dart';
import 'package:task_mate/core/network/network_caller.dart';
import 'package:task_mate/core/network/network_response.dart';
import 'package:task_mate/core/utils/urls.dart';
import 'package:task_mate/models/user_model.dart';

class UpdateProfileController extends GetxController {
  static final instance = Get.find<UpdateProfileController>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool isSuccess = false;

  Future<bool> updateProfile({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    String? photo,
    XFile? selectedImage,
    String? password,
  }) async {
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "photo": photo,
    };

    if (password != null) {
      requestBody["password"] = password;
    }

    if (selectedImage != null) {
      List<int> imageBytes = await selectedImage.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      requestBody["photo"] = convertedImage;
    }

    NetworkResponse networkResponse = await NetworkCaller.postRequest(
      url: Urls.getProfileUpdate,
      body: requestBody,
    );

    if (networkResponse.isSuccess) {
      UserModel userModel = UserModel.fromJson(requestBody);
      AuthController.saveUserData(userModel);
      debugPrint("Base64 Image: ${AuthController.userModel!.photo}");
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
