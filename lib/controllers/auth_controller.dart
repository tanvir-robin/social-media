import 'dart:convert';

import 'package:appifylab_task/Api/endpoints.dart';
import 'package:appifylab_task/helpers/alerts.dart';
import 'package:appifylab_task/models/login_response_model.dart';
import 'package:appifylab_task/views/Auth/login_screen.dart';
import 'package:appifylab_task/views/Feed/feed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find<AuthController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginResponse? loginResponse;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isRememberMe = false;

  void setRememberMe(value) {
    isRememberMe = value;
    update();
  }

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userToken') &&
        prefs.getString('userToken')!.isNotEmpty) {
      loginResponse = LoginResponse(token: prefs.getString('userToken'));
      return true;
    }
    return false;
  }

  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      Alerts.showLoading(message: 'Logging in...');
      final response = await http.post(
        Uri.parse(ApiEndoints.baseUrl + ApiEndoints.login),
        body: {
          'email': emailController.text,
          'password': passwordController.text,
          "app_token": ""
        },
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        loginResponse = LoginResponse.fromJson(responseData);
        if (isRememberMe) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('userToken', loginResponse!.token!);
        }
        Alerts.dismiss();
        Get.offAll(() => CommunityFeed());
        Alerts.showToast(message: 'Login Successful');
      } else {
        Alerts.dismiss();
        Alerts.showError(message: 'Please check your credentials');
      }
    } catch (e) {
      Alerts.dismiss();
      Alerts.showError(message: 'An error occurred. Please try again.');
    }
  }

  Future<void> logout() async {
    if (loginResponse == null) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    const url = '${ApiEndoints.baseUrl}${ApiEndoints.logout}';

    try {
      Alerts.showLoading(message: 'Logging out...');
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${loginResponse!.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await prefs.remove('userToken');
        Get.offAll(() => const LoginScreen());
        Alerts.dismiss();
        Alerts.showToast(message: 'Logout Successful');
      } else {
        Alerts.dismiss();
        Alerts.showError(message: 'An error occurred during logout');
      }
    } catch (e) {
      Alerts.dismiss();
      Alerts.showError(message: 'An error occurred during logout');
    }
  }
}
