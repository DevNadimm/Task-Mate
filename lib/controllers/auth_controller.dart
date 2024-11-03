import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_mate/models/user_model.dart';

class AuthController {
  static String? authToken;
  static UserModel? userModel;
  static const String _tokenKey = 'access-token';
  static const String _userDataKey = 'user-data';

  static Future<void> saveAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    authToken = token;
  }

  static Future<void> saveUserData(UserModel userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, jsonEncode(userData.toJson()));
    userModel = userData;
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString(_tokenKey);
    return authToken;
  }

  static Future<UserModel?> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedData = prefs.getString(_userDataKey);
    if (encodedData != null) {
      userModel = UserModel.fromJson(jsonDecode(encodedData));
      return userModel;
    }
    return null;
  }

  static Future<void> clearAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    authToken = null;
  }

  static bool isSignedIn() {
    return authToken != null;
  }
}
