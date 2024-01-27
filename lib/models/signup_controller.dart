import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logsys/models/user_model.dart';
import 'package:logsys/services/database/database_controller.dart';
import 'package:logsys/services/register/registration_repo.dart';

/// The `SignUpController` class is responsible for managing the sign-up process, including handling
/// user input and registering a new user.
class SignUpController extends GetxController {
  late SignUpController signUpController;

  ///  Global instance of `SignUpController`. This allows other classes or widgets to access the
  /// `SignUpController` instance without having to create a new instance themselves.
  static SignUpController get instance => Get.find();

  /// Text controllers to get data from textfields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final phone = TextEditingController();
  RxString phoneNo = ''.obs;
  RxString emailString = ''.obs;
  RxString passwordString = ''.obs;
  RxString fullnameString = ''.obs;

  ///  `registerUser` creates a new user.
  void registerUser(
      String email, String fullname, String phone, int? id) async {
    UserModel userModel =
        RegistrationRepo.createNewUserModel(fullname, phone, email, id);

    Map<String, dynamic> user = userModel.toJson();

    await DatabaseController.instance.createUserInDb(user);
  }

  /// Validate email
  String? emailValidator(String? value) {
    bool result = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(value!);
    return result ? null : 'Please enter a valid email';
  }

  /// Validate password
  String? passwordValidator(String? value) {
    return value!.length < 6 ? 'Password must be at least 6 characters' : null;
  }

  /// Validate name
  String? fullNameValidator(String? value) =>
      value!.isEmpty ? 'Name cannot be empty' : null;

  /// Validate phone number
  String? phoneValidator(String? value) {
    return value!.length < 10 ? 'Please enter 10 digits.' : null;
  }
}
