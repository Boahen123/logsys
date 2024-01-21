import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logsys/models/session_model.dart';
import 'package:logsys/services/login/session_repo.dart';
import 'package:logsys/services/sessions/session_controller.dart';

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

  ///  `createNewSession` creates a user session.
  void createNewSession(int? userId, String authToken, DateTime expiration,
      String password, int? id) async {
    SessionModel session =
        SessionRepo.createNewSessionModel(userId, authToken, expiration, id);

    Map<String, dynamic> sessionModel = session.toJson();

    await SessionController.instance.createSessioninDb(sessionModel);
  }
}
