import 'package:logsys/models/user_model.dart';

/// APIs for registering a user account

class RegistrationRepo {
  /// Instantiate a new user model
  static UserModel createNewUserModel(
      String fullname, String phone, String email, int? id) {
    return UserModel(id: id, fullname: fullname, phone: phone, email: email);
  }
}
