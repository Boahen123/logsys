import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Text controllers to get data from textfields
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  String? phoneValidator(String? value) {
    return value!.length < 10 ? 'Please enter 10 digits.' : null;
  }

  String? passwordValidator(String? value) {
    return (value == null || value.length < 6)
        ? 'Password must be at least 6 characters'
        : null;
  }

  /// The function initiates phone authentication and navigates to the OTP screen.
  void phoneAuthentication(String phoneNo) {}

  String encryptPassword(String password) {
    final List<int> bytes = utf8.encode(password);
    final Digest hash = sha256.convert(bytes);
    return hash.toString();
  }
}
