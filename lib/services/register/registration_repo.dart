import 'package:logsys/models/user_model.dart';

/// APIs for registering a user account

class RegistrationRepo {
  /// Instantiate a new user model
  static UserModel createNewUserModel(
      String fullname, String phone, String email, String password, int? id) {
    return UserModel(
        id: id,
        fullname: fullname,
        password: password,
        phone: phone,
        email: email);
  }

  ///  `saveUser` saves a new user to the database.
}
