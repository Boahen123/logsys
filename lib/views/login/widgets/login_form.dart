import 'package:flutter/material.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    labelText: 'Phone Number',
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.0),
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 0.05)),
                        gapPadding: 2.0)),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  label: Text('Password'),
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
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
