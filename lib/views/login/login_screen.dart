import 'package:flutter/material.dart';
import 'package:logsys/utils/constants/image_strings.dart';
import 'package:logsys/views/common_widgets/appbar.dart';
import 'package:logsys/views/common_widgets/form_footer.dart';
import 'package:logsys/views/common_widgets/form_header.dart';
import 'package:logsys/views/login/widgets/login_form.dart';

/// The `Login Screen` class that displays a login screen with a form, header, and
/// footer.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            padding: EdgeInsets.all(size.width * 0.05),
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormHeaderWidget(
                    image: loginImage,
                    title: 'Log In',
                  ),

                  /// Login Form
                  LoginForm(),

                  /// Login form footer
                  FormFooterWidget(
                      alt: "Don't have an account?",
                      auth: ' Register',
                      to: 'register')
                ]),
          ),
        ),
      ),
    );
  }
}
