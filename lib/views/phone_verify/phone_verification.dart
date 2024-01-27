import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
import 'package:logsys/services/database/phoneauth_controller.dart';
import 'package:logsys/utils/constants/colors.dart';
import 'package:logsys/views/common_widgets/appbar.dart';

const Color primaryColor = Color(0xFF121212);
const Color accentPurpleColor = Color(0xFF6A53A1);
const Color accentPinkColor = Color(0xFFF99BBD);
const Color accentDarkGreenColor = Color(0xFF115C49);
const Color accentYellowColor = Color(0xFFFFB612);
const Color accentOrangeColor = Color(0xFFEA7A3B);

class VerificationScreen1 extends StatefulWidget {
  const VerificationScreen1({super.key});

  @override
  VerificationScreen1State createState() => VerificationScreen1State();
}

class VerificationScreen1State extends State<VerificationScreen1> {
  late List<TextStyle?> otpTextStyles;
  late List<TextEditingController?> controls;
  int numberOfFields = 6;
  bool clearText = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: customAppBar(),
      body: Container(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Text(
            "Verification Code",
            style: theme.textTheme.headlineMedium,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            "We texted you a code",
            style: theme.textTheme.titleLarge,
          ),
          Text("Please enter it below", style: theme.textTheme.titleLarge),
          const Spacer(flex: 2),
          OtpTextField(
            numberOfFields: numberOfFields,
            borderColor: const Color(0xFF512DA8),
            focusedBorderColor: appcolor1,
            clearText: clearText,
            showFieldAsBox: true,
            textStyle: theme.textTheme.titleLarge,
            onCodeChanged: (String value) {
              //Handle each value
            },
            handleControllers: (controllers) {
              //get all textFields controller, if needed
              controls = controllers;
            },
            onSubmit: (String verificationCode) {
              //set clear text to clear text from all fields
              setState(() {
                clearText = true;
              });
              AuthController.instance.smsCode.value = verificationCode;
              log('smsCode: ${AuthController.instance.smsCode.value}');
              //navigate to different screen code goes here
            }, // end onSubmit
          ),
          const Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "This helps us verify every user in our market place",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ),
          Center(
            child: Text(
              "Didn't get code?",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          const Spacer(flex: 3),
          SizedBox(
            width: double.infinity,
            height: size.height * 0.06,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  loading = true;
                });
              },
              child: loading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'Sign Up',
                      style: TextStyle(color: appcolor3),
                    ),
            ),
          ),
        ]),
      ),
    );
  }
}
