import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logsys/models/signup_controller.dart';
import 'package:logsys/utils/constants/colors.dart';
import 'package:logsys/utils/constants/register_texts.dart';

/// The `SignUpFormWidget` class displays a form for signing up with fields
/// for full name, email, phone number, and password.
class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({
    super.key,
  });

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  /// FocusNode for the screen
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    // FocusNode focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    // focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> signupFormKey =
        GlobalKey<FormState>(debugLabel: 'signupFormKey');
    final Size size = MediaQuery.of(context).size;

    return Form(
        key: signupFormKey,
        child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),
              CustomFormField(
                icon: Icons.person,
                fieldName: fullNametext,
                controller: SignUpController.instance.fullname,
                validator: (String? value) =>
                    SignUpController.instance.fullNameValidator(value),
              ),
              SizedBox(height: size.height * 0.02),
              CustomFormField(
                icon: Icons.phone,
                fieldName: phoneNumbertext,
                controller: SignUpController.instance.phone,
                validator: (String? value) =>
                    SignUpController.instance.phoneValidator(value),
              ),
              SizedBox(height: size.height * 0.02),
              CustomFormField(
                icon: Icons.email,
                fieldName: emailtext,
                controller: SignUpController.instance.email,
                validator: (String? value) =>
                    SignUpController.instance.emailValidator(value),
              ),
              SizedBox(height: size.height * 0.02),
              CustomFormField(
                icon: Icons.lock,
                fieldName: passwordtext,
                controller: SignUpController.instance.password,
                validator: (String? value) =>
                    SignUpController.instance.passwordValidator(value),
              ),
              SizedBox(height: size.height * 0.08),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (signupFormKey.currentState!.validate()) {
                      signupFormKey.currentState!.save();
                      // get the texts from the form fields
                      log('full name: ${SignUpController.instance.fullname.text}');
                      log('phone : ${SignUpController.instance.phone.text}');
                      log('email: ${SignUpController.instance.email.text}');
                      log('password: ${SignUpController.instance.password.text}');
                      Get.toNamed('/login');

                      // Clear the form fields
                      SignUpController.instance.email.clear();
                      SignUpController.instance.phone.clear();
                      SignUpController.instance.fullname.clear();
                      SignUpController.instance.password.clear();
                      // authentication with phone and password
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ));
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.icon,
    required this.fieldName,
    this.focusNode,
    required this.controller,
    required this.validator,
  });

  final IconData icon;
  final String fieldName;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return TextFormField(
      controller: controller,
      validator: (String? value) => validator(value),
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        label: Text(fieldName),
        border: OutlineInputBorder(
            borderSide: const BorderSide(width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(size.width * 0.05)),
            gapPadding: 2.0),
        fillColor: appcolor2,
        focusColor: appcolor1,
        filled: true,
      ),
    );
  }
}
