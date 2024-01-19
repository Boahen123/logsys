import 'package:flutter/material.dart';
import 'package:logsys/views/common_widgets/form_header.dart';

import 'widgets/register_form_widget.dart';

/// The SignUpScreen class a sign-up form with a header, form fields,
/// and a footer with options to log in or sign up with Google.
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(size.width * 0.1),
                    child: const Column(children: [
                      FormHeaderWidget(
                        image: '',
                        title: 'Your login app',
                      ),
                      RegisterFormWidget(),
                    ])))));
  }
}
