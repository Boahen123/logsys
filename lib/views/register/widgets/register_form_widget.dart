import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  label: Text('full name'),
                ),
              ),
              SizedBox(height: size.height * 0.1),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  label: Text('emaiil'),
                ),
              ),
              SizedBox(height: size.height * 0.1),
              Obx(
                () => TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    label: Text('password'),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.1),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
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
