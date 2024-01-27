import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  Rx<String> smsCode = "".obs;

  // initialize database
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> verifyPhone(String phone) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          log('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        Get.toNamed('/phoneverify');

        if (smsCode.value.length == 6) {
          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode.value);

          // Sign the user in (or link) with the credential
          await auth.signInWithCredential(credential);
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
