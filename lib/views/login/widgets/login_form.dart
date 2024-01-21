import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logsys/models/login_controller.dart';
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
                child: ElevatedButton(
                  onPressed: () {
                    if (loginFormKey.currentState!.validate()) {
                      loginFormKey.currentState!.save();
                      // logic for loggin in

                      // Get texts from input fields
                      log(' phone: ${LoginController.instance.phoneController.text}');
                      log(' password: ${LoginController.instance.passwordController.text}');

                      // Clear the form fields
                      LoginController.instance.phoneController.clear();
                      LoginController.instance.passwordController.clear();

                      // Go to home screen
                      Get.toNamed('/home');
                    }
                  },
                  child: const Text('login'),
                ),
              ),
            ],
          ),
        ));
  }
}
