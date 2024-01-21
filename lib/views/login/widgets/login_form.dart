import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logsys/models/login_controller.dart';
import 'package:logsys/services/database/database_controller.dart';
import 'package:logsys/services/sessions/session_controller.dart';
import 'package:logsys/utils/constants/colors.dart';
// import 'package:logsys/utils/constants/colors.dart';
import 'package:logsys/utils/constants/register_texts.dart';
import 'package:logsys/views/register/widgets/register_form_widget.dart';

/// The `LoginForm` class is that represents a login form with email and password fields.
class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final LoginController loginController = LoginController.instance;
  final DatabaseController dbController = DatabaseController.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final loginFormKey = GlobalKey<FormState>(debugLabel: 'loginFormKey');

    return Form(
        key: loginFormKey,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomFormField(
                icon: Icons.phone,
                fieldName: phoneNumbertext,
                controller: LoginController.instance.phoneController,
                validator: (String? value) =>
                    LoginController.instance.phoneValidator(value),
              ),
              SizedBox(height: size.height * 0.02),
              CustomFormField(
                icon: Icons.lock,
                fieldName: passwordtext,
                controller: LoginController.instance.passwordController,
                validator: (String? value) =>
                    LoginController.instance.passwordValidator(value),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              SizedBox(
                width: double.infinity,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () async {
                    if (loginFormKey.currentState!.validate()) {
                      loginFormKey.currentState!.save();
                      // Get texts from input fields
                      log(' phone: ${LoginController.instance.phoneController.text}');
                      log(' password: ${LoginController.instance.passwordController.text}');

                      setState(() {
                        loading = true;
                      });

                      // logic for loggin in
                      if (await dbController.checkIfPhoneExists(
                          loginController.phoneController.text.trim())) {
                        Get.toNamed('/home');
                      }

                      // create user session
                      // SessionController.instance.createSession();

                      setState(() {
                        loading = false;
                      });

                      // Clear the form fields
                      loginController.phoneController.clear();
                      loginController.passwordController.clear();
                    }
                  },
                  child: loading
                      ? CircularProgressIndicator(
                          color: appcolor1,
                          strokeWidth: 4.0,
                        )
                      : const Text('login'),
                ),
              ),
            ],
          ),
        ));
  }
}
