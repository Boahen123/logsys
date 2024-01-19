import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logsys/utils/constants/colors.dart';

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
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> signupFormKey =
        GlobalKey<FormState>(debugLabel: 'signupFormKey');
    final Size size = MediaQuery.of(context).size;

    return Form(
        key: signupFormKey,
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),
              const CustomFormField(
                icon: Icons.person,
                fieldName: 'Full Name',
              ),
              SizedBox(height: size.height * 0.02),
              const CustomFormField(
                icon: Icons.phone,
                fieldName: 'Phone number',
              ),
              SizedBox(height: size.height * 0.02),
              const CustomFormField(
                icon: Icons.email,
                fieldName: 'Email',
              ),
              SizedBox(height: size.height * 0.02),
              const CustomFormField(
                icon: Icons.lock,
                fieldName: 'Password',
              ),
              SizedBox(height: size.height * 0.08),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/login');
                    if (signupFormKey.currentState!.validate()) {
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
  });

  final IconData icon;
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return TextFormField(
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
