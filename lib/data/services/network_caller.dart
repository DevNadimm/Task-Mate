import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:task_mate/data/models/network_response.dart';
import 'package:http/http.dart' as http;
import 'package:task_mate/ui/controller/auth_controller.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      final uri = Uri.parse(url);
      final token = AuthController.getAccessToken();

      final response = await http.get(
        uri,
        headers: {'token': '$token'},
      );

      printResponse(url, response);

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
      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      printResponse(url, response);

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

  static void printResponse(String url, Response response) {
    debugPrint(
      'URL: $url\nRESPONSE CODE: ${response.statusCode}\nBODY: ${response.body}',
    );
  }
}
