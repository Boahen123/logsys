import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Text controllers to get data from textfields
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  phoneValidator(String? value) {}

  String? passwordValidator(String? value) {
    return value!.length < 6 ? 'Password must be at least 6 characters' : null;
  }

  /// The function initiates phone authentication and navigates to the OTP screen.
  void phoneAuthentication(String phoneNo) {}
}
