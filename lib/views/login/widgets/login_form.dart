import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logsys/views/register/widgets/register_form_widget.dart';

/// The `LoginForm` class is that represents a login form with email and password fields.
class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

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
              const CustomFormField(
                  icon: Icons.phone, fieldName: 'Phone Number'),
              SizedBox(height: size.height * 0.05),
              const CustomFormField(icon: Icons.lock, fieldName: 'Password'),
              SizedBox(
                height: size.height * 0.1,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/home');
                    if (loginFormKey.currentState!.validate()) {
                      // logic for loggin in
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
