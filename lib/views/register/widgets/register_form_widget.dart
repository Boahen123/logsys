import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:logsys/models/login_controller.dart';
import 'package:logsys/models/signup_controller.dart';
import 'package:logsys/services/database/database_controller.dart';
import 'package:logsys/services/database/phoneauth_controller.dart';
// import 'package:logsys/services/database/database_controller.dart';
// import 'package:logsys/services/database/database_controller.dart';
import 'package:logsys/utils/constants/colors.dart';
import 'package:logsys/utils/constants/register_texts.dart';
import 'package:logsys/views/common_widgets/snackbar.dart';
// import 'package:logsys/views/common_widgets/snackbar.dart';
// import 'package:logsys/views/common_widgets/snackbar.dart';

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
  final SignUpController signUpController = SignUpController.instance;
  bool showPassword = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> signupFormKey =
        GlobalKey<FormState>(debugLabel: 'signupFormKey');
    final Size size = MediaQuery.of(context).size;
    String phoneNo = "";

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
                controller: signUpController.fullname,
                validator: (String? value) =>
                    signUpController.fullNameValidator(value),
              ),
              SizedBox(height: size.height * 0.02),
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3.0),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 0.05)),
                      gapPadding: 2.0),
                  fillColor: appcolor2,
                  focusColor: appcolor1,
                  filled: true,
                ),
                initialCountryCode: 'GH',
                onChanged: (phone) {
                  phoneNo = phone.completeNumber;
                  log(phoneNo);
                },
              ),
              SizedBox(height: size.height * 0.02),
              CustomFormField(
                icon: Icons.email,
                fieldName: emailtext,
                controller: signUpController.email,
                validator: (String? value) =>
                    signUpController.emailValidator(value),
              ),
              SizedBox(height: size.height * 0.02),
              // TextFormField(
              //   obscureText: showPassword,
              //   keyboardType: TextInputType.phone,
              //   controller: LoginController.instance.passwordController,
              //   validator: (String? value) =>
              //       LoginController.instance.passwordValidator(value),
              //   decoration: InputDecoration(
              //     suffixIcon: IconButton(
              //       icon: showPassword
              //           ? const Icon(Icons.visibility)
              //           : const Icon(Icons.visibility_off),
              //       onPressed: () {
              //         setState(() {
              //           showPassword = !showPassword;
              //         });
              //       },
              //     ),
              //     prefixIcon: const Icon(Icons.lock),
              //     label: const Text(passwordtext),
              //     border: OutlineInputBorder(
              //         borderSide: const BorderSide(width: 3.0),
              //         borderRadius:
              //             BorderRadius.all(Radius.circular(size.width * 0.05)),
              //         gapPadding: 2.0),
              //     fillColor: appcolor2,
              //     focusColor: appcolor1,
              //     filled: true,
              //   ),
              // ),
              SizedBox(height: size.height * 0.08),
              SizedBox(
                width: double.infinity,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () async {
                    if (signupFormKey.currentState!.validate()) {
                      signupFormKey.currentState!.save();

                      log(phoneNo);

                      setState(() {
                        loading = true;
                      });

                      // encrypt the password
                      // String encryptedPassword =
                      //     LoginController.instance.encryptPassword(
                      //   signUpController.password.text,
                      // );
                      // log('Encrypted password: $encryptedPassword');

                      bool phoneNoExists = await DatabaseController.instance
                          .checkIfPhoneExists(phoneNo);
                      log('Phone number exists? $phoneNoExists');
                      if (phoneNoExists) {
                        customSnackbar(
                            'Try again', 'This phone number is taken!');
                        setState(() {
                          loading = false;
                        });
                      } else {
                        await AuthController.instance.verifyPhone(phoneNo);

                        // register the user
                        signUpController.registerUser(
                            signUpController.email.text,
                            signUpController.fullname.text,
                            phoneNo,
                            null);

                        // get the texts from the form fields
                        log('full name: ${signUpController.fullname.text}');
                        log('phone : $phoneNo');
                        log('email: ${signUpController.email.text}');

                        // Clear the form fields
                        signUpController.email.clear();
                        signUpController.fullname.clear();

                        setState(() {
                          loading = false;
                        });
                      }
                    }
                  },
                  child: loading
                      ? CircularProgressIndicator(
                          color: appcolor3,
                        )
                      : Text(
                          'Sign Up',
                          style: TextStyle(color: appcolor3),
                        ),
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
    this.focusNode,
    this.keyboardType,
    required this.icon,
    required this.fieldName,
    required this.controller,
    required this.validator,
  });

  final IconData icon;
  final String fieldName;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return TextFormField(
      keyboardType: keyboardType,
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
