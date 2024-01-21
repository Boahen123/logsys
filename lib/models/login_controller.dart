import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Text controllers to get data from textfields
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  /// The phoneValidator function checks if a given value is a valid phone number with 10 digits.
  ///
  /// Args:
  ///   value (String): The value parameter is a nullable String that represents the phone number to be
  /// validated.
  ///
  /// Returns:
  ///   a string value. If the length of the input value is less than 10, it will return the message
  /// "Please enter 10 digits." Otherwise, it will return null.
  String? phoneValidator(String? value) {
    return value!.length < 10 ? 'Please enter 10 digits.' : null;
  }

  /// The function `passwordValidator` checks if a password is at least 6 characters long and returns an
  /// error message if it is not.
  ///
  /// Args:
  ///   value (String): The value parameter is a nullable String that represents the password to be
  /// validated.
  ///
  /// Returns:
  ///   a string. If the value is null or has a length less than 6, it returns the message "Password must
  /// be at least 6 characters". Otherwise, it returns null.
  String? passwordValidator(String? value) {
    return (value == null || value.length < 6)
        ? 'Password must be at least 6 characters'
        : null;
  }

  /// The function encrypts a password using the SHA-256 hashing algorithm.
  ///
  /// Args:
  ///   password (String): The `password` parameter is a string that represents the password that needs to
  /// be encrypted.
  ///
  /// Returns:
  ///   The encrypted password in the form of a string.
  String encryptPassword(String password) {
    final List<int> bytes = utf8.encode(password);
    final Digest hash = sha256.convert(bytes);
    return hash.toString();
  }
}
