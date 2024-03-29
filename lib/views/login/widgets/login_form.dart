import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logsys/models/login_controller.dart';
import 'package:logsys/models/user_model.dart';
// import 'package:logsys/models/user_model.dart';
import 'package:logsys/services/database/database_controller.dart';
import 'package:logsys/services/database/token_manager.dart';
import 'package:logsys/services/sessions/session_controller.dart';
// import 'package:logsys/services/database/token_manager.dart';
// import 'package:logsys/services/sessions/session_controller.dart';
import 'package:logsys/utils/constants/colors.dart';
// import 'package:logsys/utils/constants/register_texts.dart';
// import 'package:logsys/views/common_widgets/snackbar.dart';
// import 'package:logsys/views/register/widgets/register_form_widget.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:logsys/views/common_widgets/snackbar.dart';

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
  bool showPassword = true;
  String phoneNo = "";

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
              // CustomFormField(
              //   keyboardType: TextInputType.phone,
              //   icon: Icons.phone,
              //   fieldName: phoneNumbertext,
              //   controller: LoginController.instance.phoneController,
              //   validator: (String? value) =>
              //       LoginController.instance.phoneValidator(value),
              // ),
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
              SizedBox(height: size.height * 0.1),
              SizedBox(
                width: double.infinity,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () async {
                    if (loginFormKey.currentState!.validate()) {
                      loginFormKey.currentState!.save();
                      // Get texts from input fields
                      log(' phone: $phoneNo');

                      setState(() {
                        loading = true;
                      });
                      // retrieve the user data to expose userId
                      UserModel? user = await DatabaseController.instance
                          .retrieveUserData(phoneNo);

                      log('${user?.fullname}');

                      // generate auth token
                      String authToken = SessionController.instance
                          .generateAuthToken(user?.id);

                      // store the token locally
                      TokenManager.storeToken(authToken);

                      // create user session
                      SessionController.instance.createSession(
                        null,
                        user?.id,
                        authToken,
                        DateTime.now().add(const Duration(minutes: 5)),
                      );

                      // logic for loggin in
                      if (await dbController.checkIfPhoneExists(phoneNo)) {
                        Get.toNamed('/home', arguments: {
                          'fullname': user?.fullname ?? 'Default Fullname',
                          'phone': user?.phone ?? 'Default Phone',
                          'user_id': user?.id ?? 'Default id'
                        });
                      } else {
                        customSnackbar(
                            'Phone number not found', 'Please register');
                        await Future.delayed(const Duration(seconds: 3), () {
                          Get.toNamed('/register');
                        });
                      }
                    }

                    setState(() {
                      loading = false;
                    });

                    // Clear the form fields
                    phoneNo = "";
                  },
                  child: loading
                      ? CircularProgressIndicator(
                          color: appcolor3,
                        )
                      : const Text('login',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                ),
              ),
            ],
          ),
        ));
  }
}
