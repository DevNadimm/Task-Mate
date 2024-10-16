import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_mate/app.dart';
import 'package:task_mate/data/models/network_response.dart';
import 'package:http/http.dart' as http;
import 'package:task_mate/ui/controller/auth_controller.dart';
import 'package:task_mate/ui/screens/auth/sign_in_screen.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      final uri = Uri.parse(url);
      final token = await AuthController.getAccessToken();

      final response = await http.get(
        uri,
        headers: {'token': '$token'},
      );

      printResponse(url, response, token);

      dynamic decodeData;
      try {
        decodeData = jsonDecode(response.body);
      } catch (e) {
        decodeData = response.body;
      }

      if (response.statusCode == 200) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        _navigateToSignIn();
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: 'Unauthorized user',
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (error) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: error.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      final uri = Uri.parse(url);
      final token = await AuthController.getAccessToken();

      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'token': '$token',
        },
      );

      printResponse(url, response, token);

      dynamic decodeData;
      try {
        decodeData = jsonDecode(response.body);
      } catch (e) {
        decodeData = response.body;
      }

      if (response.statusCode == 200) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else if (decodeData is Map && decodeData['status'] == 'fail') {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decodeData['data'],
        );
      } else if (response.statusCode == 401) {
        _navigateToSignIn();
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: 'Unauthorized user',
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (error) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: error.toString(),
      );
    }
  }

  static void printResponse(String url, Response response, String? token) {
    debugPrint(
      'URL: $url\nRESPONSE CODE: ${response.statusCode}\nTOKEN: $token\nBODY: ${response.body}',
    );
  }

  static Future<void> _navigateToSignIn() async {
    await AuthController.clearAccessToken();
    Navigator.pushAndRemoveUntil(
      MyApp.navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
      (predicate) => false,
    );
  }
}
