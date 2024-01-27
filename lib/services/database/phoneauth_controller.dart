import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:logsys/models/login_controller.dart';
import 'package:logsys/models/user_model.dart';
import 'package:logsys/services/database/database_controller.dart';
import 'package:logsys/services/register/registration_repo.dart';
import 'package:logsys/views/phone_verify/phone_verification.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  Rx<String> smsCode = "".obs;
  late final Rx<User?> authenticatedUser;

  // initialize database
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();

    /// Bind the stream of Firebase auth changes to [authenticatedUser]
    authenticatedUser = Rx<User?>(auth.currentUser);
    authenticatedUser.bindStream(auth.userChanges());
    // ever(authenticatedUser, setInitialScreen);

    /// alternative approach to subscribe to streams
    authenticatedUser.listen(setInitialScreen);
  }

  /// The function checks if a user is null and navigates to different screens accordingly.
  ///
  /// Args:
  ///   user (User): The user parameter is of type User, which is an optional parameter.
  void setInitialScreen(User? user) async {
    log(" This is it: $user");
    if (user == null) {
      Get.offAllNamed('/login');
    } else {
      if (user.phoneNumber != null) {
        // retrieve the user data to expose userId
        UserModel? userModel = await DatabaseController.instance
            .retrieveUserData(user.phoneNumber!);
        Get.toNamed('/home', arguments: {
          'fullname': userModel?.fullname ?? 'Default Fullname',
          'phone': userModel?.phone ?? 'Default Phone',
          'user_id': userModel?.id ?? 'Default id'
        });
      }
    }
  }

  ///  `registerUser` creates a new user.
  Future<void> registerUser(
      String email, String fullname, String phone, int? id) async {
    UserModel userModel =
        RegistrationRepo.createNewUserModel(fullname, phone, email, id);

    Map<String, dynamic> user = userModel.toJson();

    await DatabaseController.instance.createUserInDb(user);
  }

  Future<void> verifyPhone(String phone) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Sign the user in (or link) with the auto-generated credential
        log('User credential: $credential');
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          log('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        String smsCode = await getCodeFromVerification();

        if (smsCode.isNotEmpty) {
          log("verifyPhoneCallback: smsCode: $smsCode");
          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await auth.signInWithCredential(credential);
          log('This is the user: ${auth.currentUser}');
        } else {
          log('code not received');
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}

Future<String> getCodeFromVerification() async {
  final String? result =
      await Get.to<String>(() => const VerificationScreen1());
  if (result != null) {
    return result;
  } else {
    return "";
  }
}
