import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logsys/utils/constants/colors.dart';
import 'package:logsys/utils/constants/image_strings.dart';
import 'package:logsys/views/common_widgets/appbar.dart';
import 'package:logsys/views/common_widgets/form_footer.dart';
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
            appBar: customAppBar(),
            body: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(size.width * 0.1),
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FormHeaderWidget(
                            image: registerImage,
                            title: 'Welcome back! Login',
                          ),
                          RegisterFormWidget(),
                          FormFooterWidget(
                              alt: 'Already have an account?',
                              auth: ' Log in',
                              to: 'login')
                        ])))));
  }
}
